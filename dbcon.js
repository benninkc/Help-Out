var mysql = require('mysql');

// Fill in * information to access database
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : '34.226.147.111',
  user            : 'Test',
  password        : 'current56pw',
  database        : 'help_out'
});

module.exports.pool = pool;
