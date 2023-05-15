# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_id = params[:post_id]
    @comment = PostComment.new(**comment_params, user: current_user, post_id: @post_id)

    if @comment.save
      redirect_to post_url(@post_id), notice: t('.success')
    else
      redirect_to post_url(@post_id), alert: t('.fail', errors: @comment.errors.full_messages.to_sentence)
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :ancestry)
  end
end
