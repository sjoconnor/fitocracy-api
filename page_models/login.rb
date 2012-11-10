require 'json'

module PageModels
  class Login
    attr_accessor :success, :error, :login_status, :user, :agent

    def initialize(agent, user)
      @agent = agent
      @user  = user
    end

    def login
      login_response        = @agent.post(login_uri, form_values)
      @login_status          = JSON.parse(login_response.body)
      @success               = @login_status["success"]
      @error                 = @login_status["error"] unless @login_status["error"].nil?
    end

    private

    def form_values
      {
        'csrfmiddlewaretoken' => login_form['csrfmiddlewaretoken'],
        'is_username'         => '1',
        'json'                => '1',
        'next'                => '/home/',
        'username'            => @user.username,
        'password'            => @user.password
      }
    end

    def login_page
      @agent.get(login_uri)
    end

    def login_form
      login_page.form_with(:id => 'username-login-form')
    end

    def login_uri
      'https://www.fitocracy.com/accounts/login/'
    end

  end
end