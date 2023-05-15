# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { in: 200..4000 }

  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: :user_id, inverse_of: :posts
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy
end
