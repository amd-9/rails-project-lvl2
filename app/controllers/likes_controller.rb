# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    return redirect_to post_url(params[:post_id]), error: 'Error creating like' if PostLike.exists?(:user => current_user) 

    @like = PostLike.new
    @like.user = current_user
    @like.post_id = params[:post_id]

    if @like.save
      redirect_to post_url(@like.post_id) 
    else
      redirect_to post_url(@like.post_id), error: 'Error creating like'
    end
  end

  def destroy
    @like = PostLike.find(params[:id])
    
    return redirect_to post_url(@like.post_id), error: 'Error creating like' if @like.user != current_user

    @like.destroy

    redirect_to post_url(params[:post_id])
  end
end
