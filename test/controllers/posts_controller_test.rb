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
    new_post_title = Faker::Alphanumeric.alpha(number: 10)
    new_post_body = Faker::Alphanumeric.alpha(number: 200)

    assert_difference('Post.count') do
      post posts_url, params: { post: { body: new_post_body, title: new_post_title, category_id: @category.id } }
    end

    last_post = Post.last

    assert { last_post.title == new_post_title }
    assert { last_post.body == new_post_body }
    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should not create post with title less then 5 symbols' do
    assert_no_difference('Post.count') do
      post posts_url,
           params: { post: { body: Faker::Alphanumeric.alpha(number: 200), title: Faker::Alphanumeric.alpha(number: 3),
                             category_id: @category.id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should not create post with body less then 200 symbols' do
    assert_no_difference('Post.count') do
      post posts_url,
           params: { post: { body: Faker::Alphanumeric.alpha(number: 150), title: Faker::Alphanumeric.alpha(number: 5),
                             category_id: @category.id } }
    end

    assert_response :unprocessable_entity
  end
end
