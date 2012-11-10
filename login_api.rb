require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'models/user'
require_relative 'page_models/login'

get '/my_lifts' do
  erb :index
end

post '/my_lifts' do
  @agent = Mechanize.new
  @user  = User.new({:username => params['username'], :password => params['password']})

  login_model     = ::PageModels::Login.new(@agent, @user)
  login_response  = login_model.login

  @user.x_fitocracy_user = login_response["X-Fitocracy-User"]

  my_activities = @user.activities(@agent)

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

post '/my_lifts/:lift' do
  @agent = Mechanize.new
  @user  = User.new({:username => params['username'], :password => params['password']})

  login_model     = ::PageModels::Login.new(@agent, @user)
  login_response  = login_model.login

  @user.x_fitocracy_user = login_response["X-Fitocracy-User"]

  my_activities = @user.activities(@agent)

  lift = JSON.parse(my_activities.body) \
             .detect {|lift| lift["name"] == params[:lift]}

  lift_response = @agent.get("https://www.fitocracy.com/get_history_json_from_activity/#{lift["id"]}/?max_sets=-1&max_workouts=-1&reverse=1")

  content_type :json
  JSON.pretty_generate(JSON.parse(lift_response.body))
end