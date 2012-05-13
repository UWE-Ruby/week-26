class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render :locals => { :posts => current_user.posts }
  end

  def show
  end

  def create
    post = Post.create(params[:post],:user => current_user)

    if post.twitter
      current_user.twitter.update post.message
    end

    if post.facebook
      current_user.facebook.put_wall_post post.message
    end

    redirect_to user_posts_path(current_user)
  end

end
