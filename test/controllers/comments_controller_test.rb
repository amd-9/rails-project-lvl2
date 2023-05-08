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
    new_comment_content = Faker::Quotes::Chiquito.sentence
    post post_comments_url(@post), params: { post_comment: { content: new_comment_content } }

    @post.reload

    last_comment = @post.comments.last

    assert { last_comment.content == new_comment_content }

    assert_redirected_to post_url(@post)
  end

  test 'should create comment for comment' do
    new_comment_content = Faker::Quotes::Chiquito.sentence
    post post_comments_url(@post),
         params: { post_comment: { content: new_comment_content, ancestry: "/#{@comment.id}/" } }

    @post.reload

    last_comment = @post.comments.last

    assert { last_comment.content == new_comment_content }
    assert { last_comment.parent == @comment }
  end
end
