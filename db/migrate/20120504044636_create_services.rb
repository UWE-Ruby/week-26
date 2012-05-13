class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer  "user_id"
      t.string   "provider"
      t.string   "uid"
      t.string   "uname"
      t.string   "uemail"
      t.string   "secret"
      t.string   "token"
    end
  end
end
