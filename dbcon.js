var mysql = require('mysql');

// Fill in * information to access database
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : '****',
  user            : '****',
  password        : '****',
  database        : '****'
});

module.exports.pool = pool;
