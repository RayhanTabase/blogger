require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  describe 'GET /users/:id/posts' do
    before :each do
      get '/users/1/posts'
    end
    it 'check template is correct' do
      expect(response).to render_template(:index)
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

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end
end
