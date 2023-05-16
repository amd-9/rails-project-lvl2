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
    assert_selector 'h1', text: I18n.t('.posts.index.title')
  end

  test 'should create post' do
    visit posts_url
    click_on I18n.t '.posts.new.title'

    fill_in I18n.t('.simple_form.labels.post.body'), with: @post.body
    fill_in I18n.t('.simple_form.labels.post.title'), with: @post.title
    select 'HiTech', from: I18n.t('.simple_form.labels.post.category')
    click_on 'Create Post'

    assert_text I18n.t '.post.create.success'
  end
end
