# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:creator).all.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:creator).find(params[:id])
    @comments = @post.comments.includes(:user).roots
    @like = PostLike.where(user: current_user, post: @post).first
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_url(@post), notice: t('post.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
