// backend/index.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// เชื่อมต่อ MySQL (ของ XAMPP)
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',         // XAMPP ปกติไม่มีรหัสผ่าน
  database: 'dewgasohol'
});

db.connect(err => {
  if (err) throw err;
  console.log('✅ Connected to MySQL');
});

// ✅ Route ต้อนรับหน้าแรก
app.get('/', (req, res) => {
  res.send('🚀 DewGasohol API is running.');
});

// Route จริงอื่นๆ เช่น /users
app.get('/users', (req, res) => {
  db.query('SELECT * FROM users', (err, results) => {
    if (err) return res.status(500).send(err);
    res.json(results);
  });
});

app.listen(3001, () => {
  console.log('🚀 API server running at http://localhost:3001');
});