// app.js

const express = require('express');
const bodyParser = require('body-parser');
const pool = require('./databaseConnection');

const app = express();
const port = 3000;

app.set('view engine', 'pug');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

// Display students
app.get('/', async (req, res) => {
  try {
    const students = await pool.query('SELECT * FROM students');
    res.render('index', { students: students.rows });
  } catch (error) {
    console.error('Error fetching students:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Display available rooms for booking
app.get('/available-rooms', async (req, res) => {
  try {
    const availableRooms = await pool.query('SELECT * FROM rooms WHERE availability = true');
    res.render('available-rooms', { rooms: availableRooms.rows });
  } catch (error) {
    console.error('Error fetching available rooms:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Show booking form for a specific room
app.get('/book-room/:roomId', (req, res) => {
  const roomId = req.params.roomId;
  res.render('book-room', { roomId });
});

// Process room booking
app.post('/book-room/:roomId', async (req, res) => {
  try {
    const { studentName, email, phoneNumber, duration } = req.body;
    const roomId = req.params.roomId;

    // Check if the room is available
    const room = await pool.query('SELECT * FROM rooms WHERE id = $1 AND availability = true', [roomId]);

    if (room.rows.length === 0) {
      return res.status(404).send('Room not available for booking');
    }

    // Insert student details
    const student = await pool.query('INSERT INTO students (student_name, email, phone_number) VALUES ($1, $2, $3) RETURNING id',
      [studentName, email, phoneNumber]);

    // Book the room
    await pool.query('INSERT INTO bookings (student_id, room_id, duration) VALUES ($1, $2, $3)',
      [student.rows[0].id, roomId, duration]);

    // Update room availability
    await pool.query('UPDATE rooms SET availability = false WHERE id = $1', [roomId]);

    // Update room status
    await pool.query('INSERT INTO room_status (room_id, status) VALUES ($1, $2)', [roomId, true]);

    res.redirect('/');
  } catch (error) {
    console.error('Error processing room booking:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Display room status
app.get('/room-status', async (req, res) => {
  try {
    const roomStatus = await pool.query('SELECT * FROM room_status');
    res.render('room-status', { roomStatus: roomStatus.rows });
  } catch (error) {
    console.error('Error fetching room status:', error);
    res.status(500).send('Internal Server Error');
  }
});



// Display the dashboard
app.get('/dashboard', async (req, res) => {
    try {
      // Fetch data for the dashboard
      const totalStudents = await pool.query('SELECT COUNT(*) FROM students');
      const totalBookings = await pool.query('SELECT COUNT(*) FROM bookings');
  
      const dashboardData = {
        total_students: totalStudents.rows[0].count,
        total_bookings: totalBookings.rows[0].count,
      };
  
      res.render('dashboard', { dashboardData });
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      res.status(500).send('Internal Server Error');
    }
  });
  
// ... (remaining routes)

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
