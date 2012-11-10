class User
  attr_reader :username, :password
  attr_accessor :x_fitocracy_user

  def initialize(credentials={})
    @username = credentials[:username] || ENV['fitocracy_api_username']
    @password = credentials[:password] || ENV['fitocracy_api_password']
  end

  def activities(agent)
    agent.get("https://www.fitocracy.com/get_user_activities/#{self.x_fitocracy_user}/")
  end
end