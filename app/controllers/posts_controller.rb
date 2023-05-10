# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  before_action :authenticate_user!, only: %i[new create]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.roots
    @like = PostLike.where(user: current_user).first unless current_user.nil?
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to post_url(@post), notice: t('post.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
