require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Post model' do
    user = User.create(name: 'Sam', bio: 'This is bio')
    subject { Post.new(title: 'post title', text: 'post text', author_id: user) }
    before { subject.save }

    it 'check the title is not blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'tests if title length to be invalid' do
      subject.title = 'aaa aaa poo pool lll aaa pool lll aaa pool
      lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool
      lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa pool lll aaa '
      expect(subject).to_not be_valid
    end

    it 'check if comments counter is numeric' do
      subject.comments_counter = 'not-numeric'
      expect(subject).to_not be_valid
    end

    it 'check if likes counter must be equal to or greater than zero' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
    end

    it 'check if comments counter must be equal to or greater than zero' do
      subject.comments_counter = -2
      expect(subject).to_not be_valid
    end

    it 'loads only the recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end

    it 'should save' do
      subject.save
    end
  end
end
