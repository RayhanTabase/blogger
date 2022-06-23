require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :all do
    visit destroy_user_session_path

    @user = User.new(name: 'Sam', photo: 'https://placeholder.com', password: '123456', email: 'sam@sam.com')
    @user = User.find_by(name: 'Sam') unless @user.save

    visit new_user_session_path

    fill_in 'Email', with: 'sam@sam.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    @post = @user.posts.create(title: 'Post title', text: 'Post text')
    @comment = @post.comments.create(text: 'Commnet text', author_id: @user.id)
    @post.comments.create(text: 'Commnet text', author_id: @user.id)
  end

  describe 'index' do
    before :each do
      visit(user_posts_path(@user.id))
    end

    it 'See the profile picture user' do
      all_images = page.all('img')
      expect(all_images.count).to eq(1)
    end

    it 'See the username' do
      expect(page).to have_content('Sam')
    end

    it 'See the number of posts' do
      expect(page).to have_content("Number of posts: #{@user.posts.count}")
    end

    it 'See the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'See the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'See the first comments on a post.' do
      # expect(page).to have_current_path user_posts_path(@user)
      expect(page).to have_content('Commnet text')
    end

    it 'See how many comments a post has.' do
      expect(page.find_all('.post-comments p').count).to eq(2)
    end

    it 'See how many likes a post has.' do
      expect(page).to have_content("Likes: #{@post.likes.count}")
    end

    it 'Shows the post details when any post is clicked in the post show page' do
      click_link @post.title
      expect(page).to have_content(@post.text)
    end
  end

  describe 'show' do
    before :each do
      visit user_post_path(@user, @post)
    end

    it 'shows the correct path' do
      expect(page).to have_current_path(user_post_path(@user, @post))
    end

    it 'See the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'shows who wrote the post' do
      expect(page).to have_content(@post.author.name)
    end

    it 'shows how many comments the post has' do
      expect(page).to have_content("Comments: #{@post.comments.count}")
    end

    it 'shows how many likes the post has' do
      expect(page).to have_content("Likes: #{@post.likes.count}")
    end

    it 'shows the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'shows who wrote the comment' do
      expect(page).to have_content(@comment.author.name)
      expect(page).to have_content(@comment.text)
    end
  end
end
