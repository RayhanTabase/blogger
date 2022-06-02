require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  describe 'GET /users' do
    before :each do
      get '/users'
    end
    it 'check template is correct' do
      expect(response).to render_template(:index)
    end

    it 'check correct placeholder text' do
      expect(response.body).to include('Here is a list of all users and number of posts')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /users/:id' do
    before :each do
      get '/users/1'
    end
    it 'check template' do
      expect(response).to render_template(:show)
    end

    it 'check correct placeholder text' do
      expect(response.body).to include('Here is a the user page')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end
end