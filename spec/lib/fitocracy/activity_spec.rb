require 'spec_helper'
require_relative '../../../lib/fitocracy/activity'

module ::Fitocracy
  describe Activity do
    class JSON; end
    let(:user) { double('user') }
    let(:agent) { double('agent') }
    let(:activities) do
      [
        {
          count: 1,
          id: 507,
          name: "Anusara Yoga"
        },
        {
          count: 298,
          id: 1,
          name: "Barbell Bench Press"
        }
      ]
    end

    subject { Activity.new(user: user, agent: agent, activity_name: 'Barbell Bench Press') }

    describe '#get_all_activities_for_user' do
      it 'returns a users activities' do
        agent.should_receive(:get)
        ::Fitocracy::Paths.should_receive(:activities_uri)
        user.should_receive(:x_fitocracy_user) \
            .and_return('12345')

        subject.get_all_activities_for_user
      end
    end
  end
end