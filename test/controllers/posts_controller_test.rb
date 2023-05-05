# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @post = posts(:one)
    @category = categories(:one)
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, title: @post.title, category_id: @category.id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end
