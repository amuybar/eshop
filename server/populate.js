// populate.js

const fs = require('fs');
const csv = require('csv-parser');
const sqlite3 = require('sqlite3');

const db = new sqlite3.Database('products.db');

function createTable() {
  db.run(`CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    imgurl TEXT,
    description TEXT,
    quantity TEXT
  )`);
}

function insertData(csvFilename) {
  fs.createReadStream(csvFilename)
    .pipe(csv())
    .on('data', (row) => {
      db.run(`INSERT INTO products (name, price, imgurl, description, quantity)
              VALUES (?, ?, ?, ?, ?)`,
        [row.name, row.price, row.imgurl, row.description, row.quantity]);
    })
    .on('end', () => {
      console.log(`Data inserted from ${csvFilename}`);
      db.close();
    });
}

function createTablesAndInsertData() {
    // Define table names and corresponding CSV filenames
    const tables = [
        { tableName: 'phones', csvFilename: 'phone.csv' },
        { tableName: 'clothes', csvFilename: 'cloth.csv' },
        { tableName: 'shoes', csvFilename: 'shoe.csv' }
    ];

    // Create tables and insert data
    tables.forEach(({ tableName, csvFilename }) => {
        createTable(tableName);
        insertData(csvFilename, tableName);
    });
}

// Call function to create tables and insert data
createTablesAndInsertData();
