class HomeController < ApplicationController
  def index
    render :locals => { :posts => Post.all }
  end
end
