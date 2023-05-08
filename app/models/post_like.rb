# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id, inverse_of: false
  belongs_to :post
end
