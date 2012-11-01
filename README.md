fitocracy-api
=============

# Setup

You should be able to simply clone the project, perform a `bundle install` and then start your Sinatra server with `be ruby -rubygems login_api.rb`.

In `login.api.rb` you'll need to swap out the Username and Password with your actual credentials. Eventually this will be moved to either a separate YAML file or possibly environment variables.

# My Lifts

Hitting `localhost:4567/my_lifts` will return JSON with all of your lifts. Very soon I will implement a route that will allow access to a specific lifts statistics, but this is a  start.

You can hit `localhost:4567/my_lifts/Barbell Bench Press`, to get the bench press representation. The lift name must match exactly as it does on Fitocracy.