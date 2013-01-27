require 'spec_helper'
require_relative '../../../lib/fitocracy/paths'

module ::Fitocracy
  describe Paths do
    subject { Paths }

    describe "#fitocracy_root_uri" do
      specify { subject.fitocracy_root_uri.should == 'https://www.fitocracy.com/' }
    end

    describe "#login_uri" do
      specify { subject.login_uri.should == 'https://www.fitocracy.com/accounts/login/' }
    end

    describe "#activities_uri" do
      it "returns a users activities uri" do
        expected_uri = "https://www.fitocracy.com/get_user_activities/1/"
        subject.activities_uri(1).should == expected_uri
      end
    end

    describe "#activity_history_uri" do
      it "returns the specified activities' uri" do
        expected_uri = "https://www.fitocracy.com/get_history_json_from_activity/1/?max_sets=-1&max_workouts=-1&reverse=1"
        subject.activity_history_uri(1).should == expected_uri
      end
    end
  end
end