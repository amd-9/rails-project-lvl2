# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, class_name: 'PostComment'
  has_many :likes, class_name: 'PostLike'
end
