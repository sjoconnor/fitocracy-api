require_relative '../lib/fitocracy/paths'

class User
  include ::Fitocracy::Paths

  attr_reader :username, :password
  attr_accessor :x_fitocracy_user, :agent, :error

  def initialize(hash={})
    @username = hash[:username] || ENV['fitocracy_api_username']
    @password = hash[:password] || ENV['fitocracy_api_password']
    @agent    = hash[:agent]

    validate_user
  end

  def activities
    @activities ||= agent.get(activities_uri(self.x_fitocracy_user))
  end

  def activity(activity_name)
    JSON.parse(activities.body) \
        .detect {|activity| activity["name"] == activity_name}
  end

  def activity_log(activity_name)
    activity = activity(activity_name)
    agent.get(activity_history_uri)
  end

  private

  def validate_user
    @error ||= 'Username is missing' if username.empty?
    @error ||= 'Password is missing' if password.empty?
  end
end