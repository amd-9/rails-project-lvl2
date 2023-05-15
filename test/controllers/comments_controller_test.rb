# frozen_string_literal: true

require 'test_helper'
require 'faker'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test 'should create comment for post' do
    attrs = {
      content: Faker::Quotes::Chiquito.sentence
    }

    post post_comments_url(@post), params: { post_comment: attrs }

    @post.reload

    created_comment = @post.comments.find_by(attrs)

    assert { created_comment }

    assert_redirected_to post_url(@post)
  end

  test 'should create comment for comment' do
    attrs = {
      content: Faker::Quotes::Chiquito.sentence,
      ancestry: "/#{@comment.id}/"
    }

    post post_comments_url(@post), params: { post_comment: attrs }

    @post.reload

    created_comment = @post.comments.last

    assert { created_comment }
    assert { created_comment.parent == @comment }
  end
end
