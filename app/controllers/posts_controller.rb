class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def show
  end

  def create
    post = Post.create(params[:post])

    if post.twitter
      current_user.twitter.update post.message
    end
    require 'ruby-debug' ; debugger
    if post.facebook
      current_user.facebook.put_wall_post post.message
    end
    
    redirect_to user_posts_path(current_user)
  end

end
