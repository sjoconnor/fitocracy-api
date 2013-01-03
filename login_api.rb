require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'models/user'
require_relative 'page_models/login'

get '/' do
  "Available Paths"
end

get '/my_activities' do
  erb :index
end

before '/user/*' do
  @agent = Mechanize.new
  @user  = User.new({ agent: @agent})

  halt(401, @user.error) if @user.error

  login_model     = ::PageModels::Login.new(@agent, @user)
  login_response  = login_model.login
  login_json      = JSON.parse(login_response.body)

  halt(401, login_json['error']) unless login_json['success']

  @user.x_fitocracy_user  = login_response["X-Fitocracy-User"]
end

get '/user/activities' do
  my_activities = @user.activities

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

post '/user/activities' do
  my_activities = @user.activities

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

get '/user/activity_history' do
  activity_log = @user.activity_log(params[:activity_name])

  content_type :json
  JSON.pretty_generate(JSON.parse(activity_log.body))
end