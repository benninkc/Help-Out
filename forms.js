var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});
var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 7550);
app.use(express.static('public'));

// Main page of database.
app.get('/',function(req,res,next){
  res.render('home');
});

app.get('/eventpost', function(req,res,next){
  res.render('eventPost');
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

//Browse Volunteers page
app.get('/browseVolunteers', function(req,res,next){

  var context = {};
  mysql.pool.query('SELECT vid, firstname, lastname FROM volunteer WHERE firstname IS NOT NULL', function(err, rows, fields){
    if(err){
        next(err);
        return;
    }
    context.volunteer = rows;
    res.render('browseVolunteers', context);
  });
});

// Browse Hosts page
app.get('/browseHosts', function(req,res,next){

  var context = {};
  mysql.pool.query('SELECT hid, hostorg FROM host', function(err, rows, fields){
    if(err){
        next(err);
        return;
    }
    context.host = rows;
    res.render('browseHosts', context);
  });
});


// Find an Event Host by Category page
app.get('/categoryHostSearch', function(req,res,next){

  var context = {};
  mysql.pool.query('SELECT cid, categoryname FROM category', function(err, rows, fields){
    if(err){
        next(err);
        return;
    }
    context.category = rows;
    res.render('categoryHostSearch', context);
  });
});

//Returns skilled volunteer information
app.get('/select-skilled-volunteers', function(req, res, next){
  var context = {};
  //console.log(req.query);
  mysql.pool.query('SELECT V.vid, V.firstname, V.lastname, V.email FROM volunteer V INNER JOIN volunteer_skill VS on V.vid = VS.vid INNER JOIN skill S on S.sid = VS.sid WHERE S.skillname = ?', [req.query.volunteer_skill], function(err, rows, fields){
    if(err){
	next(err);
	return;
    }	
    //console.log(rows.length);
    context.skillname = req.query.volunteer_skill;
    context.volunteer = rows;
    res.render('skilledVolunteerSearchResults', context);
  });
});

//Returns 'host by category' information
app.get('/select-hosts-by-category', function(req, res, next){
  var context = {};
  //console.log(req.query);
  mysql.pool.query('SELECT H.hid, H.hostorg, H.email FROM host H INNER JOIN category C ON H.cid = C.cid WHERE C.categoryname = ?', [req.query.host_category], function(err, rows, fields){
      if(err){
      next(err);
      return;
    }
    //console.log(rows.length);
    context.categoryname = req.query.host_category;
    context.host = rows;
    res.render('categoryHostSearchResults', context);
  });
});

// Event host info page
app.get('/select-host-info', function(req, res, next){
  var context = {};
  mysql.pool.query('SELECT H.hostorg, H.email, C.categoryname FROM host H INNER JOIN category C ON C.cid = H.cid WHERE H.hid = ?', [req.query.hid], function (err, rows, fields){
        if(err){
        next(err);
        return;
      }

      context.host = rows;
	
      mysql.pool.query('SELECT E.eventname FROM event E WHERE E.hid = ?', [req.query.hid], function (err, rows, fields){
          if(err){
          next(err);
          return;
        }

        context.events = rows;
 	res.render('hostInformation', context);
    });
  });
});

//Individual volunteer info: unsure if needed
app.get('/select-volunteer-info', function(req, res, next){
  var context = {};
  mysql.pool.query('SELECT V.firstname, V.lastname, V.email FROM volunteer V WHERE V.vid = ?', [req.query.vid], function (err, rows, fields){
	if(err){
	next(err);
	return;
      }

      context.volunteer = rows;
    
      mysql.pool.query('SELECT E.eventname FROM volunteer V INNER JOIN volunteer_event VE ON V.vid = VE.vid INNER JOIN event E ON VE.eid = E.eid WHERE V.vid = ?', [req.query.vid], function (err, rows, fields){
          if(err){
          next(err);
          return;
        }

        context.events = rows;
        //res.render('volunteerInformation', context);
    
        mysql.pool.query('SELECT S.skillname FROM volunteer V INNER JOIN volunteer_skill VS on V.vid = VS.vid INNER JOIN skill S ON VS.sid = S.sid WHERE V.vid = ?', [req.query.vid], function (err, rows, fields){
            if(err){
            next(err);
            return;
          }

          context.skills = rows;
	  res.render('volunteerInformation', context);
      });
    });
  });
});

app.get('/locationSearch',function(req,res,next){
  var context = {};
  var tableData = [];
  var minLat = req.query.latMin;
  var minLng = req.query.lngMin;
  var maxLat = req.query.latMax;
  var maxLng = req.query.lngMax;
  //console.log(minLat);
  //console.log(minLng);
  //console.log(maxLat);
  //console.log(maxLng);

  var query = 'SELECT `eventname`, `eventdescription`, `eventlatitude`, ' +
  '`eventlongitude`, `eid` FROM `event` WHERE eventlatitude > ? && ' + 
  'eventlatitude < ? && eventlongitude > ? && eventlongitude < ?';
  mysql.pool.query(query, [minLat, maxLat, minLng, maxLng], function(err, rows, fields){
    if(err){
      next(err);
      return;
    }

    for (var key in rows) {
      tableData.push(rows[key]);
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

  mysql.pool.query(query, [req.query.eid], function(err, rows, fields){
    if(err){
      next(err);
      return;
    }

    for (var key in rows) {
      tableData.push(rows[key]);
    }

    context.table = tableData;
    res.render('eventInformation', context);
  });
});

app.post('/register',function(req,res,next){
  var vidVal;
  var emailFound = false;

  mysql.pool.query('SELECT `vid` FROM `volunteer` WHERE `email` = ?', [req.body.email], function(err, rows, fields){
    if(err){
      console.log("Error occurred.");
      next(err);
      return;
    }
    for (var key in rows) {
      vidVal = rows[key].vid;
      emailFound = true;
    }
    if (!emailFound) {
      mysql.pool.query('INSERT INTO `volunteer` (`email`) VALUES (?)', [req.body.email], function(err, result){
        if(err){
          console.log("Error occurred.");
          next(err);
          return;
        }
        mysql.pool.query('SELECT MAX(`vid`) AS `vid` FROM `volunteer`', function(err, rows, fields){
          if(err){
            next(err);
            return;
          }

          var vidVal = rows[0].vid;
        });
      });
    }

    mysql.pool.query('INSERT INTO `volunteer_event` (`vid`, `eid`) VALUES (?, ?)', [vidVal, req.body.eid], function(err, result){
      if(err){
        console.log("Error occurred.");
        next(err);
        return;
      }    
    });
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
