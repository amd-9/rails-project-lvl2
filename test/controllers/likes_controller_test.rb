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
  end

  test 'should remove like from post' do
    sign_in users(:three)

    assert_changes 'PostLike.count', from: PostLike.count, to: PostLike.count - 1 do
      delete post_like_url(@post, @first_like)
    end
  end

  test 'should not create multiple likes for post from same user' do
    sign_in users(:three)

    assert_no_difference 'PostLike.count' do
      post post_likes_url(@post)
    end

    assert_redirected_to post_url(@post)    
  end

  test 'should not remove like of another user from post' do
    delete post_like_url(@post, @second_like)


    assert { PostLike.exists? @second_like.id }
    assert_redirected_to post_url(@post)
  end
end
