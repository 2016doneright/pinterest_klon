class AddDupIdToRepin < ActiveRecord::Migration
  def change
    add_index :repins, :dup_id
  end
end
