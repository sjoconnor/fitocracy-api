require_relative '../lib/fitocracy/paths'

class User
  # include ::Fitocracy::Paths

  attr_reader :username, :password
  attr_accessor :x_fitocracy_user, :agent, :error

  def initialize(hash={})
    @username = hash[:username] || ENV['fitocracy_api_username']
    @password = hash[:password] || ENV['fitocracy_api_password']
    @agent    = hash[:agent]

    validate_user
  end

  private

  def validate_user
    @error ||= 'Username is missing' if username.empty?
    @error ||= 'Password is missing' if password.empty?
  end
end