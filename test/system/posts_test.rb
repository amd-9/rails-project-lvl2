# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @post = posts(:one)
    @category = categories(:one)
  end

  test 'visiting the index' do
    visit posts_url
    assert_selector 'h1', text: 'Posts'
  end

  test 'should create post' do
    visit posts_url
    click_on 'New post'

    fill_in 'Body', with: @post.body
    fill_in 'Title', with: @post.title
    select 'HiTech', from: 'Category'
    click_on 'Create Post'

    assert_text I18n.t '.post.create.success'
  end
end
