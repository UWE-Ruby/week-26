class Post < ActiveRecord::Base
  attr_accessible :message, :twitter, :facebook
  
  belongs_to :user
  
end
