# CS361 Project

Volunteering platform for matching small neighborhood volunteering opportunities with volunteers. Features include the ability to search for volunteer opportunities, to sign up for opportunities, and post volunteer opportunities.

## Homework 6

| Story | Tasks | Who | Status |
| ------- | -------- | ----- | -----|
| View Volunteer Event | Create MySQL Table of Events, Create Queries to Extract Event Results, Create Web Page to Show list of hyperlinked results, Create Event Detail page to show to User | Nathan, Tanya | Draft MySQL portions posted
| Locational Search | Create homepage, Add Lat Long to Event Table, Create Filter by geography query, Link geofilter to events query built above, create map page to view local events on a map, Link Mapped events to event detail page built above | Nathan, Casey, Tanya, Aaron |
| Search for skilled volunteers | Create table of volunteers, Create table of skills, Many-to-many  relationship table, Create skills query, Create web page to display list of qualified volunteers | Aaron, Casey, Sarah, Nathan |
| Volunteer for Event | Add "volunteer" button to Event detail page, Create many-to-many table between volunteers and events, Use of new button adds relationship between volunteer and event to this table| Casey, Sarah |
| Thank volunteers | Create "Event has ended" addition to Event Detail Page, Create query of volunteers who participated in event, Add display of volunteer list to Detail page for events that have ended | Nathan, Aaron |
| Register Volunteer | Tasks TBD based on research.... | Casey, Sarah, Aaron |

## Homework 7

We'll figure this part out next week!

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


