class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # , :confirmable
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  before_validation :set_defaults

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  # has_secure_password

  ROLES = %i[admin default].freeze

  def recent_posts
    posts.last(3)
  end

  def set_defaults
    self.posts_counter ||= 0
  end

  def is?(requested_role)
    role == requested_role.to_s
  end
end
