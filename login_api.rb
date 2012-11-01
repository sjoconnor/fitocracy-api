require 'sinatra'
require 'mechanize'
require 'json'
require 'pry'
require_relative 'user'
require_relative 'page_models/login'

get '/my_lifts' do
  @agent = Mechanize.new
  @user  = User.new({:username => 'Username', :password => 'Password'})

  page_model_login = ::PageModels::Login.new(@agent, @user)
  login_response = page_model_login.login

  my_activities = @agent.get("https://www.fitocracy.com/get_user_activities/#{login_response["X-Fitocracy-User"]}/")

  content_type :json
  JSON.pretty_generate(JSON.parse(my_activities.body))
end

get '/my_lifts/:lift' do
  @agent = Mechanize.new
  @user  = User.new({:username => 'Username', :password => 'Password'})

  login_page = @agent.get('https://www.fitocracy.com/accounts/login/')
  login_form = login_page.form_with(:id => 'username-login-form')

  form_values = {
    'csrfmiddlewaretoken' => login_form['csrfmiddlewaretoken'],
    'is_username'         => '1',
    'json'                => '1',
    'next'                => '/home/',
    'username'            => @user.username,
    'password'            => @user.password
  }

  my_home_page = @agent.post('https://www.fitocracy.com/accounts/login/', form_values)

  my_activities = @agent.get("https://www.fitocracy.com/get_user_activities/#{my_home_page["X-Fitocracy-User"]}/")

  my_lift = JSON.parse(my_activities.body).detect {|lift| lift["name"] == params[:lift]}

  content_type :json
  JSON.pretty_generate(my_lift)
end