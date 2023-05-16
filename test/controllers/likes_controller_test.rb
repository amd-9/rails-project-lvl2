# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @post = posts(:one)
    @first_like = post_likes(:one)
    @second_like = post_likes(:two)
  end

  test 'should add like to post' do
    assert_difference('PostLike.count') do
      post post_likes_url(@post)
    end

    @post.reload

    added_like = @post.likes.find_by(user: users(:one))

    assert { added_like }
    assert_redirected_to post_url(@post)
  end

  test 'should be possible to add like for different posts' do
    second_post = posts(:two)

    post post_likes_url(@post)
    post post_likes_url(second_post)

    second_post.reload

    added_like = second_post.likes.find_by(user: users(:one))

    assert { added_like }
    assert_redirected_to post_url(second_post)
  end

  test 'should remove like from post' do
    sign_in users(:three)

    delete post_like_url(@post, @first_like)

    @post.reload

    deleted_like = @post.likes.find_by(user: users(:three))

    assert_not deleted_like
    assert_redirected_to post_url(@post)
  end

  test 'should not create multiple likes for post from same user' do
    sign_in users(:three)

    assert_no_difference 'PostLike.count' do
      post post_likes_url(@post)
    end

    assert_redirected_to post_url(@post)
  end

  test 'should not remove like of another user from post' do
    assert_no_difference 'PostLike.count' do
      delete post_like_url(@post, @second_like)
    end

    assert_redirected_to post_url(@post)
  end
end
