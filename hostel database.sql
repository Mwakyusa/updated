Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password for user postgres:
psql (15.3)
WARNING: Console code page (437) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

postgres=# drop database hostel_management_system;
ERROR:  database "hostel_management_system" does not exist
postgres=# \l
                                                           List of databases
   Name    |  Owner   | Encoding |        Collate        |         Ctype         | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+-----------------------+-----------------------+------------+-----------------+-----------------------
 hms       | postgres | UTF8     | English_Tanzania.1252 | English_Tanzania.1252 |            | libc            |
 postgres  | postgres | UTF8     | English_Tanzania.1252 | English_Tanzania.1252 |            | libc            |
 template0 | postgres | UTF8     | English_Tanzania.1252 | English_Tanzania.1252 |            | libc            | =c/postgres          +
           |          |          |                       |                       |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | English_Tanzania.1252 | English_Tanzania.1252 |            | libc            | =c/postgres          +
           |          |          |                       |                       |            |                 | postgres=CTc/postgres
(4 rows)


postgres=# -- Create a new database
postgres=# CREATE DATABASE hostel_management_system;
CREATE DATABASE
postgres=#
postgres=# -- Connect to the new database
postgres=# \c hostel_management_system;
You are now connected to database "hostel_management_system" as user "postgres".
hostel_management_system=#
hostel_management_system=# -- Students table
hostel_management_system=# CREATE TABLE students (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   student_name VARCHAR(100) NOT NULL,
hostel_management_system(#   email VARCHAR(100) NOT NULL,
hostel_management_system(#   phone_number VARCHAR(20) NOT NULL
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Rooms table
hostel_management_system=# CREATE TABLE rooms (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   room_number VARCHAR(10) NOT NULL,
hostel_management_system(#   availability BOOLEAN DEFAULT true
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Bookings table
hostel_management_system=# CREATE TABLE bookings (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   student_id INT REFERENCES students(id),
hostel_management_system(#   room_id INT REFERENCES rooms(id),
hostel_management_system(#   booking_date DATE DEFAULT CURRENT_DATE,
hostel_management_system(#   duration INT NOT NULL
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Room Status table
hostel_management_system=# CREATE TABLE room_status (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   room_id INT REFERENCES rooms(id),
hostel_management_system(#   status BOOLEAN DEFAULT false,
hostel_management_system(#   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Dashboard Data table
hostel_management_system=# CREATE TABLE dashboard_data (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   total_students INT,
hostel_management_system(#   total_bookings INT,
hostel_management_system(#   total_hostels INT,
hostel_management_system(#   last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Hostels table
hostel_management_system=# CREATE TABLE hostels (
hostel_management_system(#   id SERIAL PRIMARY KEY,
hostel_management_system(#   name VARCHAR(255),
hostel_management_system(#   location VARCHAR(255),
hostel_management_system(#   capacity INT
hostel_management_system(# );
CREATE TABLE
hostel_management_system=#
hostel_management_system=# -- Insert sample data into students table
hostel_management_system=# INSERT INTO students (student_name, email, phone_number)
hostel_management_system-# VALUES
hostel_management_system-#   ('John Doe', 'john.doe@example.com', '123-456-7890'),
hostel_management_system-#   ('Jane Smith', 'jane.smith@example.com', '987-654-3210'),
hostel_management_system-#   ('Alice Johnson', 'alice.johnson@example.com', '555-123-4567');
INSERT 0 3
hostel_management_system=#
hostel_management_system=# -- Insert sample data into rooms table
hostel_management_system=# INSERT INTO rooms (room_number, availability)
hostel_management_system-# VALUES
hostel_management_system-#   ('101', true),
hostel_management_system-#   ('102', true),
hostel_management_system-#   ('103', false),
hostel_management_system-#   ('201', true),
hostel_management_system-#   ('202', false),
hostel_management_system-#   ('203', true);
INSERT 0 6
hostel_management_system=#
hostel_management_system=# -- Insert sample data into bookings table
hostel_management_system=# INSERT INTO bookings (student_id, room_id, duration)
hostel_management_system-# VALUES
hostel_management_system-#   (1, 1, 7),
hostel_management_system-#   (2, 3, 14),
hostel_management_system-#   (3, 6, 5);
INSERT 0 3
hostel_management_system=#
hostel_management_system=# -- Insert sample data into room_status table
hostel_management_system=# INSERT INTO room_status (room_id, status)
hostel_management_system-# VALUES
hostel_management_system-#   (1, true),
hostel_management_system-#   (2, false),
hostel_management_system-#   (3, true),
hostel_management_system-#   (4, false),
hostel_management_system-#   (5, true),
hostel_management_system-#   (6, false);
INSERT 0 6
hostel_management_system=#
hostel_management_system=# -- Insert sample data into dashboard_data table
hostel_management_system=# INSERT INTO dashboard_data (total_students, total_bookings, total_hostels)
hostel_management_system-# VALUES
hostel_management_system-#   (3, 3, 6);
INSERT 0 1
hostel_management_system=#
hostel_management_system=# -- Insert sample data into hostels table
hostel_management_system=# INSERT INTO hostels (name, location, capacity)
hostel_management_system-# VALUES
hostel_management_system-#   ('Hostel A', 'Location A', 50),
hostel_management_system-#   ('Hostel B', 'Location B', 60),
hostel_management_system-#   ('Hostel C', 'Location C', 70);
INSERT 0 3
hostel_management_system=#