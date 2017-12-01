# CS361 Project

Volunteering platform for matching small neighborhood volunteering opportunities with volunteers. Features include the ability to search for volunteer opportunities, to sign up for opportunities, and post volunteer opportunities.

## Homework 7

| Story | Tasks | Who | Status |
| ------- | -------- | ----- | -----|
| View Volunteer Event | Create Event detail page to show to User || HW6 remainder |
| Locational Search | Create Map page to view local events on a map, Link Mapped events to Event Detail page built above | Nathan | HW6 remainder |
| Search for Skilled Volunteers | Create Web Page to show list of hyperlinked volunteers, Create Volunteer detail page (if we need one?) || HW6 remainder |
| Volunteer Event Registration | Create Add “volunteer” button to Event detail page, Create many-to-many relationship table between volunteers and events, Volunteer button adds relationship to above table | Casey & Sarah | |
| Category Search | Create MySQL Table of Categories, Add Category ID attribute as a foreign key to the Event Manager table, Create category query, Create web page to show list of hyperlinked event managers, Create event manager detail page | Aaron | |
| Browse Results | Create page to display search query results, Use google map API to insert map, List hyperlinked results on page after map | | |
| Browse Volunteers | Create query to get attribute information of volunteer, Create page to display attribute information |||
| Post Event | Create page with forms to enter in event information, Check if user is registered, Create a new Event in the Event Table with an associated Event Manager ID added as a foreign key |||
| Delete Event | Create delete button on my events page | Create query to delete event from Event Table | Create success page to read and display query result |||


## Homework 6

| Story | Tasks | Who | Status |
| ------- | -------- | ----- | -----|
| View Volunteer Event | Create MySQL Table of Events, Create Queries to Extract Event Results, Create Web Page to Show list of hyperlinked results, Create Event Detail page to show to User | Nathan, Tanya | Draft MySQL portions posted, Still need to create list of events page, Event detail page created
| Locational Search | Create homepage, Add Lat Long to Event Table, Create Filter by geography query, Link geofilter to events query built above, create map page to view local events on a map, Link Mapped events to event detail page built above | Nathan, Casey, Tanya, Aaron | Homepage created, Lat/Long added to table, Geography filter created
| Search for skilled volunteers | Create table of volunteers, Create table of skills, Many-to-many  relationship table, Create skills query, Create web page to display list of qualified volunteers | Aaron, Casey, Sarah, Nathan | Table of volunteers created, Table of skills created, Skills Query created
| Thank volunteers | Create "Event has ended" addition to Event Detail Page, Create query of volunteers who participated in event, Add display of volunteer list to Detail page for events that have ended | Nathan, Aaron |
| Register Volunteer | Tasks TBD based on research.... | Casey, Sarah, Aaron |


## How to Set up this project

--Using a Terminal--
1) Create a directory on you local machine where you want to store the code files.
2) Navigate to inside that directory using your terminal.
3) Go to the github page for the repository you want to download.
4) Click on clone or download and copy the link to you clipboard
5) In your terminal type in git clone and paste the results.  For instance:
git clone https://github.com/natez56/CS361Project.git
6) You should now have all the repository files on your computer.

--Helpful Git commands--
1) Use git status to check if your files are up to date with the ones online.
2) Use git pull to replace your local files with the ones online.

--MySQL--
1) Download the MySQL community edition.
2) Install
3) Create a new schema in the connected server
4) Select your new schema under schemas in the left side.
5) Run Queries to set up your tables and populate them.

--Node, Express, Handlebars
1) On your local machine type sudo apt-get install nodejs
2) then sudo apt-get install npm
2) Then: npm install express
3) Then: npm install express-handlebars
4) Then: npm install mysql

--Node with MySQL
1) Open the dbcon.js file
2) Under host write localhost
3) For user you'll want to check in MySQL what the user for your database is listed as.  Might just be root.
4) Type your password for your MySQL user account.
5) Under database enter the name of the schema you want to access.

--Google Maps JS API--
1) Follow the guide here: https://developers.google.com/maps/documentation/javascript/get-api-key
2) Once you have your auth key insert it into the HTML located in the main.handlebars page in the layouts folder.

--Getting Set Up On Flip--
1) Log on to a server such as flip3.engr.oregonstate.edu
2) Create a folder for CS361.
3) Navigate to the folder you just created
4) Go to github and navigate to the CS361 project page.
5) Click on the green button that says Clone or download and copy the link.
6) In your flip terminal type: git clone and then paste what you copied. Should look like:
git clone https://github.com/natez56/CS361Project.git
7) Now you should have a folder named CS361 in your directory.  Navigate to that folder.
8) Use the command node form.js to run the required js.
9) Navigate to http://flip3.engr.oregonstate.edu:9005 to view the rendered page.
10) Note if the page is not loading it is most likely because the port is in use to fix this follow these steps
11) Open the forms.js file.
12) Find the line that says app.set('port', 9000); and change the port to something else like 5005.
13) Save the file.  Make sure the files are up to date on flip with the new port.
14) Run node forms.js again and go back to the page http://flip3.engr.oregonstate.edu:5005 <- now with the new port.

