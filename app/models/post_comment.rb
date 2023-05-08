# frozen_string_literal: true

class PostComment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 5 }

  belongs_to :user
  belongs_to :post

  has_ancestry
end
