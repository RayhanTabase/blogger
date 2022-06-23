require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :all do
    @user = User.new(name: 'Sam', photo: 'https://placeholder.com', password: '123456', email: 'sam@sam.com')
    @user2 = User.new(name: 'Bob', photo: 'https://placeholder.com', password: '123456', email: 'bob@bob.com')
    @user = User.find_by(name: 'Sam') unless @user.save
    @user2 = User.find_by(name: 'Bob') unless @user2.save

    visit new_user_session_path

    fill_in 'Email', with: 'sam@sam.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  describe 'index' do
    before :each do
      visit new_user_session_path
      # fill_in 'Email', with: 'sam@sam.com'
      # fill_in 'Password', with: '123456'
      # click_button 'Log in'
      # visit users_path
    end

    it 'shows the username of all users' do
      expect(page).to have_content('Sam')
      expect(page).to have_content('Bob')
      expect(page).to have_content('Create')
    end

    # it 'See the profile picture for each user' do
    #   all_images = page.all('.image')
    #   expect(all_images.count).to eq(2)
    # end

    it 'See the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 0')
      # expect(page.find_all('.num-posts').count).to eq(2)

    end

    # it 'When I click on a user, I am redirected to the show page.' do
    #   click_link 'Sam'
    #   expect(page).to have_current_path(user_path(@user.id))
    # end
  end

#   describe 'show' do
#     before :each do
#       visit new_user_session_path
#       fill_in 'Email', with: 'tom@example.com'
#       fill_in 'Password', with: '222555'
#       click_button 'Log in'

#       if @first_user.posts.count < 3
#         unless @first_user.posts.find_by(title: 'Post title 1')
#           @post1 = @first_user.posts.create!(title: 'Post title 1',
#                                              text: 'Post text 1')
#         end
#         @post2 = @first_user.posts.create!(title: 'Post title 2', text: 'Post text 2')
#         @post3 = @first_user.posts.create!(title: 'Post title 3', text: 'Post text 3')
#       end
#       @post1 = @first_user.posts.find(1)
#       @post2 = @first_user.posts.find(2)
#       @post3 = @first_user.posts.find(3)
#       click_link 'Tom'
#     end

#     it 'shows the correct path' do
#       expect(page).to have_current_path(user_path(@first_user))
#     end

#     it 'shows the user profile picture' do
#       all_images = page.all('img')
#       expect(all_images.count).to eq(1)
#     end

#     it 'shows the user username' do
#       expect(page.find('h4', text: 'Tom')).to be_truthy
#     end

#     it 'shows the user post count' do
#       expect(page).to have_content("Posts: #{@first_user.posts.count}")
#     end

#     it 'shows the user bio' do
#       expect(page).to have_content(@first_user.bio)
#     end

#     it 'shows the user\'s first three posts' do
#       expect(page.find_all('div', class: 'post-card').count).to eq(3)
#     end

#     it 'shows the user\'s posts when any post is clicked' do
#       click_link @post1.title
#       expect(page).to have_current_path(user_posts_path(@first_user))
#     end

#     it 'shows the post details when any post is clicked in the post index page' do
#       click_link @post1.title
#       click_link @post1.title
#       expect(page).to have_current_path(user_post_path(@first_user, @post1))
#     end
#   end
end