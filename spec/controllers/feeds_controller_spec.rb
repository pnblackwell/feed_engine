require 'spec_helper'

describe FeedsController do
  describe 'Feeds#new' do    
    it 'renders the new feeds template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'Feeds#create' do
    context 'when doing a username search' do
      it 'saves the input of the new feeds template' do
        post :create, { :feed =>
                              { :name => 'kittens', :subdomain => 'kitties',
                                :searches_attributes => {"0" =>{
                                            :value => 'jcasimir',
                                            :search_type => 'username'}}
                              }
                      }
        expect(response).to redirect_to root_url(subdomain: 'kitties')
      end
    end

    context 'when doing a keyword search' do
      it 'saves the input of the new feeds template' do
         post :create, { :feed =>
                              { :name => 'kittens', :subdomain => 'kitties',
                                :searches_attributes => {"0" =>{
                                            :value => 'kittens',
                                            :search_type => 'keyword'}}
                              }
                      }
        expect(response).to redirect_to root_url(subdomain: 'kitties')
      end
    end
  end
end