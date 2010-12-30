class PostsController < ApplicationController
  before_filter :authenticate

  def new
    @post = Post.new
    @post.post_type = params[:post_type]
  end
  
  def show
    @post = Post.find(params[:id])
    
    @response = @post.responses.create
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.find_all_by_post_type(params[:post_type], :order => 'posted_at DESC')
    render "#{params[:post_type]}index.html.erb"
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
    if params[:post_id].nil? then
      # This is a root post - not a response
      @post = Post.new(params[:post])
    else
      # This is a response, so attach to parent post
      parent = Post.find(params[:post_id])
      @post = parent.responses.build(params[:post])
      @post.title = "Re: #{parent.title}"
    end

    @post.user = current_user
    save_success =  @post.save
    puts "AJAX : #{request.xhr?}"
    respond_to do |format|
    format.html { 
      if request.xhr? then
          render :text => save_success ? 'Y' : 'N'
      else
          if save_success then
            redirect_to (@post.parent || @post)
          else
            render :action => :new
          end
      end
    }
    end
  end
end
