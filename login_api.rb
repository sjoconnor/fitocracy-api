require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'models/user'
require_relative 'page_models/login'
require_relative 'lib/fitocracy/activity'

get '/' do
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

get '/user/:username/activities' do
  activity = ::Fitocracy::Activity.new(user:  @user,
                                       agent: @agent)

  all_activites = activity.get_all_activities_for_user

  content_type :json
  JSON.pretty_generate(JSON.parse(all_activites.body))
end

get '/user/:username/activity/:activity_name' do
  activity = ::Fitocracy::Activity.new(user:          @user,
                                       agent:         @agent,
                                       activity_name: params[:activity_name])

  activity_data = activity.activity_log

  content_type :json
  JSON.pretty_generate(JSON.parse(all_activites.body))
end