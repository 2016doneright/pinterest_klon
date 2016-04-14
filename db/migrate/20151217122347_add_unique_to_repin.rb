class AddUniqueToRepin < ActiveRecord::Migration
  def change
    add_index :repins, [:board_id, :pin_id], :unique => true
  end
end
