class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :room, presence: true, length: { maximum: 4 },
                   format: { with: /\A[0-9]+\z/ },
                   uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :favorites
  has_many :likes, through: :favorites, source: :post
  has_many :notices
  
  def feed_posts
    Post.where(id: self.like_ids).or(Post.where(user_id: self)) 
  end

  def feed_notices
    Notice
  end
  
  def like(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end

  def unlike(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  def like?(post)
    self.likes.include?(post)
  end

end
