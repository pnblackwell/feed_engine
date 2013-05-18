require "spec_helper"

describe UserMailer do
  describe "signup_confirmation" do
    let!(:user) {User.create(:username => 'jen', :email => '7maples@example.com')}
    let(:mail) { UserMailer.signup_confirmation }
    before { ActionMailer::Base.deliveries = [] }

    it "confirms delivery" do
      UserMailer.signup_confirmation(user).deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end
