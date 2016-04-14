class AddIndexToPin < ActiveRecord::Migration
  def change
    add_index :pins, :board_id
  end
end
