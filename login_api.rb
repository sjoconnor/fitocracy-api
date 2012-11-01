require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'user'
require_relative 'page_models/login'

get '/my_lifts' do
  @agent = Mechanize.new
  @user  = User.new({:username => 'Username', :password => 'Password'})

  login_model     = ::PageModels::Login.new(@agent, @user)
  login_response  = login_model.login

  my_activities = @agent.get("https://www.fitocracy.com/get_user_activities/#{login_response["X-Fitocracy-User"]}/")

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

get '/my_lifts/:lift' do
  @agent = Mechanize.new
  @user  = User.new({:username => 'Username', :password => 'Password'})

  login_model     = ::PageModels::Login.new(@agent, @user)
  login_response  = login_model.login

  my_activities = @agent.get("https://www.fitocracy.com/get_user_activities/#{login_response["X-Fitocracy-User"]}/")

  lift = JSON.parse(my_activities.body) \
             .detect {|lift| lift["name"] == params[:lift]}

  lift_response = @agent.get("https://www.fitocracy.com/get_history_json_from_activity/#{lift["id"]}/?max_sets=-1&max_workouts=-1&reverse=1")

  content_type :json
  JSON.pretty_generate(JSON.parse(lift_response.body))
end