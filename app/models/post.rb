class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.last(5)
  end
end
