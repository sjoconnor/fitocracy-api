fitocracy-api
=============

Feel free to look me up and follow me on fitocracy as sjoconnor.

# Disclaimer

This is an unofficial API to help you get your lifting data from Fitocracy. I am in no way affiliated with Fitocracy, and do not represent them. Additionally, I have no desire to be responsible for your username and password, so although I may create forms to make certain things easier to access, I will not publically host this app. Please be careful when using this and keep your username/password secure.

# Setup

You should be able to simply clone the project, perform a `bundle install` and then start your Sinatra server with `be ruby -rubygems login_api.rb`.

In `login.api.rb` you'll need to swap out the Username and Password with your actual credentials, or you can optionally set the following environment variables in `user.rb`.

````ruby
class User

  ...

  def initialize(hash={})
    @username = hash[:username] || ENV['fitocracy_api_username']
    @password = hash[:password] || ENV['fitocracy_api_password']
    @agent = hash[:agent]
  end

  ...

end
````

# My Lifts

Hitting `localhost:4567/user/activities` will return JSON with all of your lifts. Very soon I will implement a route that will allow access to a specific lifts statistics, but this is a  start.

Sample output:

````JSON
[
  {
    "count": 197,
    "id": 2,
    "name": "Barbell Squat"
  },
  {
    "count": 187,
    "id": 1,
    "name": "Barbell Bench Press"
  },
  {
    "count": 175,
    "id": 183,
    "name": "Standing Barbell Shoulder Press (OHP)"
  },
  {
    "count": 116,
    "id": 283,
    "name": "Chin-Up"
  },
  {
    "count": 93,
    "id": 3,
    "name": "Barbell Deadlift"
  },
  {
    "count": 61,
    "id": 425,
    "name": "Romanian Deadlift"
  }
]
````

# Specific Lifts

You can get data regarding a specific link by appending the exercise name, exactly as it comes from Fitocracy, like so: `localhost:4567/user/activity_history`. Pass the activity name ("Barbell Bench Press") as a param. The lift name must match exactly as it does on Fitocracy.

Sample output:

````JSON
[
  {
    "actions": [
      {
        "effort0_imperial_string": "80 lb",
        "effort0_imperial": 80.0,
        "effort1_imperial_unit": {
          "id": 31,
          "abbr": "reps",
          "name": "Reps"
        },
        "new_quest": null,
        "effort2_metric_unit": null,
        "effort1_metric_string": "6 reps",
        "effort2_string": null,
        "effort3_unit": null,
        "effort4_metric_string": null,
        "effort0_metric": 36.28738963043027,
        "is_pr": false,
        "effort5_imperial_unit": null,
        "effort4_string": null,
        "id": 32349306,
        "effort2_unit": null,
        "actiondate": "2012-02-02",
        "effort5_metric_unit": null,
        "effort0_metric_string": "36.3 kg",
        "effort0_unit": {
          "id": 35,
          "abbr": "lb",
          "name": "Pounds"
        }
     ]
  }
]
````

# Changelog

### November 22, 2012
* Routes were changed so login validations could be ran before each request.
* All routes are now POSTs, instead of GETs. Doing a GET with usernames/passwords didn't feel right, for obvious reasons.
* Extracted all paths into a separate module to keep them all together.
* Added an additional form, primarily to make testing easier.

# TODO

* ~~Switch to POSTS and set up a form accepting a username/password combination~~
* Should not have to log in for every request
	* Keep user session around
* ~~Actually look up the lifts for a specific exercise~~
* Possibly adding good charts for lifts
* Massive refactor
	* ~~Eliminate login duplication~~
	* Extract pages into objects