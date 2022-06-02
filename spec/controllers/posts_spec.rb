require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  describe 'GET /users/:id/posts' do
    before :each do
      get '/users/1/posts'
    end
    it 'check template is correct' do
      expect(response).to render_template(:index)
    end

    it 'check correct placeholder text' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /users/:id/posts/:id' do
    before :each do
      get '/users/1/posts/1'
    end
    it 'check template' do
      expect(response).to render_template(:show)
    end

    it 'check correct placeholder text' do
      expect(response.body).to include('Here is a post')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end
end