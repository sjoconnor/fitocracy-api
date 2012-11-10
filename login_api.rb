require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'models/user'
require_relative 'page_models/login'

get '/my_activities' do
  erb :index
end

post '/my_activities' do
  @agent = Mechanize.new
  @user  = User.new({ :username => params['username'],
                      :password => params['password'],
                      :agent    => @agent})

  login_model             = ::PageModels::Login.new(@agent, @user)
  @user.x_fitocracy_user  = login_model.login["X-Fitocracy-User"]

  my_activities = @user.activities

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

get '/my_activities/:activity_name' do
  @agent = Mechanize.new
  @user  = User.new({ :username => params['username'],
                      :password => params['password'],
                      :agent    => @agent})

  login_model             = ::PageModels::Login.new(@agent, @user)
  @user.x_fitocracy_user  = login_model.login["X-Fitocracy-User"]

  activity_log = @user.activity_log(params[:activity_name])

  content_type :json
  JSON.pretty_generate(JSON.parse(activity_log.body))
end