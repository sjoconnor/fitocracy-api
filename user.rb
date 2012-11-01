class User
  attr_reader :username, :password

  def initialize(credentials)
    @username = credentials[:username]
    @password = credentials[:password]
  end
end