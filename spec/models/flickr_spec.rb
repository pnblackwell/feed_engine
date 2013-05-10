require 'spec_helper'

describe Flickr do
  
  it 'creates a new object with a username' do
    flicker = Flickr.new(username: 'jcasimir')
    expect(flicker.username).to eq(:username => 'jcasimir')
  end

  describe "#get_user_id" do 
    it "returns a user's id" do 
      flicker = Flickr.new('jcasimir')
      flicker.stub(:get_user_id).and_return("69341872@N00")

      expect(flicker.get_user_id).to eq "69341872@N00"
    end
  end

  describe "#get_photos" do
    it 'returns JSON photo data' do
      flicker = Flickr.new('dannytestapp')
      flicker.stub(:get_photos).and_return('[{"id"=>"8719370310", "owner"=>"95556281@N07", "secret"=>"f7c220dcc2", "server"=>"7374", "farm"=>8, "title"=>"map", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]')

      expect(flicker.get_photos).to eq('[{"id"=>"8719370310", "owner"=>"95556281@N07", "secret"=>"f7c220dcc2", "server"=>"7374", "farm"=>8, "title"=>"map", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]')
    end
  end

end