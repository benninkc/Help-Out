var mysql = require('mysql');

// Fill in * information to access database
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'localhost:8888',
  user            : 'root',
  password        : 'root',
  database        : 'CS361'
});

module.exports.pool = pool;
