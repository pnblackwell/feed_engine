require 'spec_helper'

describe User do

  describe ".from_omniauth" do

    context "given a user already exists in the db" do
      before(:each) do
        @user = User.create! do |user|
          user.provider =  "twitter",
          user.provider_id = "243274632",
          user.username = "Danny__Garcia"
        end
      end

      it "finds the user" do
        danny = User.from_omniauth({provider: 'twitter', uid: "243274632"})
        expect(danny.username).to eq @user.username
      end

      it "doesn't change the user count" do
        expect{User.from_omniauth( { provider: 'twitter', uid: "243274632" } )}.to change(User, :count).by(0)
      end
    end
  end

  describe ".create_from_omniauth" do

    context "given a new user" do

      it "creates a new user" do
        expect{User.create_from_omniauth(
              { 'provider' => 'twitter', 'uid' => "243274632",
              'info' => {'nickname' => "danny__garcia"}
              }
          )}.to change(User, :count).by(1)
      end
    end
  end
end