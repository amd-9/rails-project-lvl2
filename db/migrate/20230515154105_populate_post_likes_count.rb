class PopulatePostLikesCount < ActiveRecord::Migration[7.0]
  def change
    Post.find_each do |post|
      Post.reset_counters(post.id, :likes)
    end
  end
end
