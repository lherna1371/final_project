[![Build Status](https://travis-ci.org/eugenefilimonov/final_project.png)](https://travis-ci.org/eugenefilimonov/final_project)
[![Coverage Status](https://coveralls.io/repos/eugenefilimonov/final_project/badge.png?branch=master)](https://coveralls.io/r/eugenefilimonov/final_project?branch=master)

Eight Week Project

# FlikBites

FlikBites allows for users to view crowdsourced photos of restaurant dishes
The deployed version can be found at http://flikbites.herokuapp.com/.

# SETUP AND CONFIGURATION

* Ruby version - 1.9.3p194

* Rails version - 4.0.0

* RSpec version - 2.14.5

* System dependencies

* Configuration
  - The database runs on Postgresql, port 5432 in testing and development
  -localhost is 3000

* Database creation
  - Upon cloning the repo, run <tt>bundle install</tt> to prepare the gems for use

* Database initialization
  -Run 'bundle exec rake db:create' to create the database
  -Run <tt>bundle exec rake db:migrate</tt> to build all necessary tables

* How to run the test suite
  - <tt>rspec spec<tt> runs tests through RSpec
  - Navigating to the /specs route will run the Jasmine tests
