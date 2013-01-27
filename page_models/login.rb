require_relative '../lib/fitocracy/paths'

module PageModels
  class Login
    def initialize(agent, user)
      @agent = agent
      @user  = user
    end

    def login
      @agent.post(::Fitocracy::Paths.login_uri, form_values)
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

    def login_form
      login_page = @agent.get(::Fitocracy::Paths.login_uri)

      login_page.form_with(:id => 'username-login-form')
    end

  end
end