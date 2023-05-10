# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = PostComment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to post_url(@comment.post_id), notice: t('.success')
    else
      redirect_to post_url(@comment.post_id), notice: t('.fail')
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :ancestry)
  end
end
