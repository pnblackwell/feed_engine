require 'spec_helper'

describe FeedsController do
  describe 'Feeds#new' do
    it 'renders the new feeds template' do
      user = User.create(provider: 'twitter', provider_id: 1, username: 'honey', email: 'w@w.com')
      controller.stub(:current_user).and_return(user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'Feeds#create' do
    context 'when doing a username search' do
      it 'saves the input of the new feeds template' do
        user = User.create(provider: 'twitter', provider_id: 1, username: 'honey', email: 'w@w.com')
        controller.stub(:current_user).and_return(user)

        post :create, params: {:feed =>{:name=>"kiittens", :subdomain=>"kiitties",
                       :searches_attributes=>{"0"=>{:search_type=>"username",
                        :value=>"jcasimir"}}}, :source=> ["flickr"]}

        expect(response).to redirect_to root_url(subdomain: 'kiitties')
      end
    end

    context 'when doing a keyword search' do
      it 'saves the input of the new feeds template' do
        user = User.create(provider: 'twitter', provider_id: 1, username: 'honey', email: 'w@w.com')
        controller.stub(:current_user).and_return(user)

         post :create, params: {:feed =>{:name=>"kittens", :subdomain=>"kitties",
                       :searches_attributes=>{"0"=>{:search_type=>"keyword",
                        :value=>"cats"}}}, :source=> ["flickr"]}

        expect(response).to redirect_to root_url(subdomain: 'kitties')
      end
    end
  end
end
