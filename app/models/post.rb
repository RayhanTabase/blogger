class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_counter

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.last(5)
  end
end
