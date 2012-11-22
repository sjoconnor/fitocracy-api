module Fitocracy
  module Paths
    def fitocracy_root_uri
      'https://www.fitocracy.com/'
    end

    def login_uri
      fitocracy_root_uri + 'accounts/login/'
    end

    def activities_uri
      fitocracy_root_uri + "/get_user_activities/#{self.x_fitocracy_user}/"
    end

    def activity_history_uri
      fitocracy_root_uri + "/get_history_json_from_activity/#{activity["id"]}/?max_sets=-1&max_workouts=-1&reverse=1"
    end
  end
end