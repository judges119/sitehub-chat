class AddLastCheckinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_checkin, :integer
  end
end
