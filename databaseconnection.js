// databaseConnection.js

const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'hostel_management_system',
  password: '2002',
  port: 5432,
});

module.exports = pool;
