class Post < ActiveRecord::Base
  attr_accessible :message, :twitter, :facebook, :user

  belongs_to :user

end
