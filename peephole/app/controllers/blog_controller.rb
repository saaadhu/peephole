class BlogController < ApplicationController
  def new
    @post = Post.new
  end
end
