class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { greater_than_or_equal_to: 0 }


  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.last(5)
  end
end
