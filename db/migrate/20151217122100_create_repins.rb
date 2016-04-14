class CreateRepins < ActiveRecord::Migration
  def change
    create_table :repins do |t|
      t.references :user, index: true, foreign_key: true
      t.references :board, index: true, foreign_key: true
      t.references :pin, index: true, foreign_key: true
      t.integer :dup_id

      t.timestamps null: false
    end
  end
end
