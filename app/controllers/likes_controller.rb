# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_id = params[:post_id]
    return redirect_to post_url(@post_id), status: :unprocessable_entity if PostLike.exists?(post_id: @post_id,
                                                                                             user: current_user)

    @like = PostLike.new(user: current_user, post_id: @post_id)

    return redirect_to post_url(@like.post_id) if @like.save

    redirect_to post_url(@like.post_id), error: t('.fail')
  end

  def destroy
    @like = PostLike.find(params[:id])

    return redirect_to post_url(@like.post_id), status: :unprocessable_entity if @like.user != current_user

    @like.destroy

    redirect_to post_url(params[:post_id])
  end
end
