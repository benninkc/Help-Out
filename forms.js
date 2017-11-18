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

// Gets sent information from geocode function
// Generates data to used in the geocode.js function to create a search result.
// Page
//
// Find a Skilled Volunteer Page
app.get('/skilledVolunteerSearch', function(req,res,next){

  var context = {};
  mysql.pool.query('SELECT sid, skillname FROM skill', function(err, rows, fields){
    if(err){
	next(err);
	return;
    }
    context.skill = rows;
    res.render('skilledVolunteerSearch', context);
  });
});
app.post('/locationSearch',function(req,res,next){
  var context = {};
  var tableData = [];
  var minLat = req.body.latMin;
  var minLng = req.body.lngMin;
  var maxLat = req.body.latMax;
  var maxLng = req.body.lngMax;
  console.log(minLat);
  console.log(minLng);
  console.log(maxLat);
  console.log(maxLng);

  var query = 'SELECT `eventname`, `eventdescription` FROM `event` WHERE ' +
  'eventlatitude > ? && eventlatitude < ? && eventlongitude > ? && eventlongitude < ?';
  mysql.pool.query(query, [minLat, maxLat, minLng, maxLng], function(err, rows, fields){
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
    res.send(context);
  });
});


// Event information (will be used for additional information page)
app.get('/eventInformation',function(req,res,next){
  var context = {};
  var tableData = [];
  var query = 'SELECT `eid`, `hid`, `eventdate`, `eventname`,' + 
    '`eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`' +
    'FROM `event` WHERE `eid` = ?';

  mysql.pool.query(query, [req.body.eid], function(err, rows, fields){
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
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
