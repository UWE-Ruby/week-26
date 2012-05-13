class Post < ActiveRecord::Base
  attr_accessible :message, :twitter, :facebook
end
