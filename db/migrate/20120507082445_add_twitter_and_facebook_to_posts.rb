class AddTwitterAndFacebookToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :twitter, :boolean
    add_column :posts, :facebook, :boolean
  end
end
