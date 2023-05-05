# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    if PostLike.exists?(user: current_user)
      return redirect_to post_url(params[:post_id]),
                         error: t('.fail')
    end

    @like = PostLike.new user: current_user, post_id: params[:post_id]

    if @like.save
      redirect_to post_url(@like.post_id)
    else
      redirect_to post_url(@like.post_id), error: t('.fail')
    end
  end

  def destroy
    @like = PostLike.find(params[:id])

    return redirect_to post_url(@like.post_id), error: t('.fail') if @like.user != current_user

    @like.destroy

    redirect_to post_url(params[:post_id])
  end
end
