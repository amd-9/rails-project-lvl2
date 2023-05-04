# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = PostComment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@comment.post_id), notice: 'Post comment was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :ancestry)
  end
end
