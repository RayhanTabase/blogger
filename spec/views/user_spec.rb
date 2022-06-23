require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :each do
    visit destroy_user_session_path

    @user = User.new(name: 'Sam', photo: 'https://placeholder.com', password: '123456', email: 'sam@sam.com')
    @user2 = User.new(name: 'Bob', photo: 'https://placeholder.com', password: '123456', email: 'bob@bob.com')
    @user = User.find_by(name: 'Sam') unless @user.save
    @user2 = User.find_by(name: 'Bob') unless @user2.save

    @post = @user.posts.create(title: '1 Post title', text: 'Post text')
    @user.posts.create(title: '2 Post title', text: 'Post text')
    @user.posts.create(title: '3 Post title', text: 'Post text')

    visit new_user_session_path

    fill_in 'Email', with: 'sam@sam.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit users_path
  end

  describe 'index' do
    it 'shows the username of all users' do
      expect(page).to have_content('Sam')
      expect(page).to have_content('Bob')
    end

    it 'See the profile picture for each user' do
      expect(page.all('img').count).to eq(2)
    end

    it 'See the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 0')
      expect(page.find_all('.num-posts').count).to eq(2)
    end

    it 'When I click on a user, I am redirected to the show page.' do
      click_link 'Sam'
      expect(page).to have_current_path(user_path(@user.id))
    end
  end

  describe 'show' do
    it 'shows the correct path' do
      click_link 'Sam'
      expect(page).to have_current_path(user_path(@user))
    end

    it 'shows the user profile picture' do
      click_link 'Sam'
      expect(page.all('img').count).to eq(1)
    end

    it 'shows the user username' do
      click_link 'Sam'
      expect(page).to have_content('Sam')
    end

    it 'shows the user post count' do
      click_link 'Sam'
      expect(page).to have_content("Number of posts: #{@user.posts.count}")
    end

    it 'shows the user bio' do
      click_link 'Sam'
      expect(page).to have_content(@user.bio)
    end

    it 'shows the user\'s first three posts' do
      click_link 'Sam'
      expect(page.find_all('.post-card').count).to eq(3)
    end

    it 'shows the user\'s posts when see all is clicked' do
      click_link 'Sam'
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user.id))
    end

    it 'shows the post details when any post is clicked in the post index page' do
      click_link 'Sam'
      click_link 'See all posts'
      click_link @post.title
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
