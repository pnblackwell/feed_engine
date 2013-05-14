require 'spec_helper'

describe Flickr do
  context 'setting up a new Flickr object' do
    before(:each) do
      search = Search.create(value: 'jcasimir', search_type: 'username')
      @flicker = Flickr.new(search)
    end

    it 'creates a new object with a username' do
      expect(@flicker.value).to eq 'jcasimir'
      expect(@flicker.search_type).to eq 'username'
    end

    describe "#get_user_id" do
      it "returns a user's id" do
        @flicker.stub(:get_user_id).and_return("69341872@N00")

        expect(@flicker.get_user_id).to eq "69341872@N00"
      end
    end
  end

  describe "#get_photos" do
    it 'returns JSON photo data' do
      search = Search.create(value: 'dannytestapp', search_type:'username')
      flicker = Flickr.new(search)
      flicker.stub(:get_photos).and_return('[{"id"=>"8719370310", "owner"=>"95556281@N07", "secret"=>"f7c220dcc2", "server"=>"7374", "farm"=>8, "title"=>"map", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]')

      expect(flicker.get_photos).to eq('[{"id"=>"8719370310", "owner"=>"95556281@N07", "secret"=>"f7c220dcc2", "server"=>"7374", "farm"=>8, "title"=>"map", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]')
    end
  end

  describe '.clean_results' do
    it 'takes in the Flickr output and cleans it to just the info we want' do
      results = [ {"id"=>"6335473183", "owner"=>"69341872@N00", "secret"=>"d07e47ec51", "server"=>"6060", "farm"=>7, "title"=>"", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0},
                  {"id"=>"5738180053", "owner"=>"69341872@N00", "secret"=>"78e25a82de", "server"=>"2002", "farm"=>3, "title"=>"IMG_0962", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}
                ]
      cleaned_list = [{ photo_url: "http://farm7.staticflickr.com/6060/6335473183_d07e47ec51.jpg",
                        owner: "69341872@N00", photo_title: "", source: 'flickr' },
                      { photo_url: "http://farm3.staticflickr.com/2002/5738180053_78e25a82de.jpg",
                        owner: "69341872@N00", photo_title: "IMG_0962", source: 'flickr'}
                      ]
      expect(Flickr.clean_results(results)).to eq cleaned_list
    end
  end
end
