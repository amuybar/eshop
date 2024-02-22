// app.js

const express = require('express');
const sqlite3 = require('sqlite3');

const app = express();
const PORT = 3000;

const db = new sqlite3.Database('products.db');

app.use(express.json());

app.get('/products', (req, res) => {
  db.all('SELECT * FROM products', (err, rows) => {
    if (err) {
      console.error(err.message);
      res.status(500).send('Internal Server Error');
    } else {
      res.json(rows);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
