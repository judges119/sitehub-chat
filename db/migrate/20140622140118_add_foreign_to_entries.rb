class AddForeignToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :room_id, :integer
  end
end
