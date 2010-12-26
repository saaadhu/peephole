class PostsController < ApplicationController

  before_filter :authenticate, :except => [:index]

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes params[:post]
      redirect_to posts_url
    else
      render :action => :edit
    end

  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = session[:user]
    if @post.save then
      redirect_to posts_url
    else
      render :action => :new
    end
  end
end
