class User
  attr_reader :username, :password
  attr_accessor :x_fitocracy_user, :agent

  def initialize(hash={})
    @username = hash[:username] || ENV['fitocracy_api_username']
    @password = hash[:password] || ENV['fitocracy_api_password']
    @agent = hash[:agent]
  end

  def login
  end

  def activities
    @activities ||= agent.get("https://www.fitocracy.com/get_user_activities/#{self.x_fitocracy_user}/")
  end

  def activity(activity_name)
    JSON.parse(activities.body) \
        .detect {|activity| activity["name"] == activity_name}
  end

  def activity_log(activity_name)
    activity = activity(activity_name)
    agent.get("https://www.fitocracy.com/get_history_json_from_activity/#{activity["id"]}/?max_sets=-1&max_workouts=-1&reverse=1")
  end
end