var mysql = require('mysql');

// Fill in * information to access database
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'localhost',
  user            : '***',
  password        : '***',
  database        : 'help_out'
});

module.exports.pool = pool;
