class User
  attr_reader :username, :password

  def initialize(credentials={})
    @username = credentials[:username] || ENV['fitocracy_api_username']
    @password = credentials[:password] || ENV['fitocracy_api_password']
  end
end