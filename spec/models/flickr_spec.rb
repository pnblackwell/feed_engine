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

  describe '#get_keyword_photos' do
    it 'returns a array of photos from flickr' do
      search = Search.create(value:'asparagus', search_type:'keyword')
      @flicker = Flickr.new(search)
      keyword = 'asparagus'
      photos = @flicker.get_keyword_photos(keyword)
     
      expect(photos.count).to eq(30)
    end
  end

  describe '.clean_results' do
    it 'takes in the Flickr output and cleans it to just the info we want' do
      results = [ {"id"=>"6335473183", "owner"=>"69341872@N00","secret"=>"d07e47ec51", "server"=>"6060", "farm"=>7, "title"=>"", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0, "owner_name"=>"pookie"},
                  {"id"=>"5738180053", "owner"=>"69341872@N00", "secret"=>"78e25a82de", "server"=>"2002", "farm"=>3, "title"=>"IMG_0962", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0, "owner_name"=>"walnut"}
                ]

      cleaned_list = [{ source: 'flickr', source_id: 6335473183, photo_title: "", owner: "pookie",
                        photo_url: "http://farm7.staticflickr.com/6060/6335473183_d07e47ec51.jpg"
                         },
                      { source: 'flickr', source_id: 5738180053, photo_title: "IMG_0962", owner: "walnut",
                        photo_url: "http://farm3.staticflickr.com/2002/5738180053_78e25a82de.jpg"
                        }
                      ]
      expect(Flickr.clean_results(results)).to eq cleaned_list
    end
  end
end
