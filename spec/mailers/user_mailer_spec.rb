require "spec_helper"

describe UserMailer do
  describe "signup_confirmation" do
    let(:mail) { UserMailer.signup_confirmation }
    before { ActionMailer::Base.deliveries = [] }

    it "renders the headers" do
      mail.subject.should eq("Welcome to Photoline")
      mail.to.should eq(user.email)
      mail.from.should eq(["customer_service@photoline.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Thank you for signing up.")
    end

    it "confirms delivery" do
      #this test isn't doing SHIT - how to test delivery?
      user = Factory(:user)
      UserMailer.signup_confirmation(user).deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end

end
