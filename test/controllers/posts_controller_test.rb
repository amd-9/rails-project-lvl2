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
    attrs = {
      title: Faker::Alphanumeric.alpha(number: 10),
      body: Faker::Alphanumeric.alpha(number: 200),
      category_id: @category.id
    }

    assert_difference('Post.count') do
      post posts_url, params: { post: attrs }
    end

    created_post = Post.find_by(attrs)

    assert { created_post }
    assert_redirected_to post_url(created_post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should not create post with title less then 5 symbols' do
    attrs = {
      ody: Faker::Alphanumeric.alpha(number: 200),
      title: nil,
      category_id: @category.id
    }

    post posts_url, params: { post: attrs }

    assert_response :unprocessable_entity
  end
end
