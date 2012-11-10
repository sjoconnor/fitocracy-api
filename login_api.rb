require 'sinatra'
require 'mechanize'
require 'json'
require 'sinatra/flash'
require 'pry'
require_relative 'models/user'
require_relative 'page_models/login'

enable :sessions

get '/my_activities' do
  erb :index
end

post '/my_activities' do
  @agent = Mechanize.new
  @user  = User.new(@agent, { :username => params['username'],
                              :password => params['password']})

  login_model = ::PageModels::Login.new(@agent, @user)
  home = login_model.login
  binding.pry

  if login_model.success
    my_activities = @user.activities

    content_type :json
    JSON.pretty_generate(JSON.parse(my_activities.body))
  else
    content_type :json
    JSON.pretty_generate(JSON.parse(my_activities.body))
  end
end

post '/my_activity' do
  @agent = Mechanize.new
  @user  = User.new(@agent, { :username => params['username'],
                              :password => params['password']})

  login_model             = ::PageModels::Login.new(@agent, @user)
  @user.x_fitocracy_user  = login_model.login["X-Fitocracy-User"]

  activity_log = @user.activity_log(params[:activity_name])

  content_type :json
  JSON.pretty_generate(JSON.parse(activity_log.body))
end