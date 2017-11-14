//Nathan Zimmerman
//06/10/2017

var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});
var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 9000);
app.use(express.static('public'));

// Main page of database.
app.get('/',function(req,res,next){
  res.render('home');
});

// Movie page with movie table, add movie form, and remove movie form.
app.get('/eventInformation',function(req,res,next){
  var context = {};
  var tableData = [];
  var query = 'SELECT `eid`, `hid`, `eventdate`, `eventname`,' + 
    '`eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`' +
    'FROM `events` WHERE `eid` = ?';

  mysql.pool.query(query, [rec.body.eid], function(err, rows, fields){
    if(err){
      next(err);
      return;
    }
    
    var data = JSON.stringify(rows);
    var json = JSON.parse(data);

    for (var key in json) {
      tableData.push(json[key]);
    }

    context.table = tableData;
    res.render('eventInformation', context);
  });
});

// Error handling below.
app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('errorPage', { error: err });
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
