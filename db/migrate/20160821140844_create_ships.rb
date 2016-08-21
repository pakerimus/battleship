class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.references :board, index: true, foreign_key: true
      t.string :shiptype
      t.string :status
      t.string :start_position
      t.string :orientation
      t.text :cells

      t.timestamps null: false
    end
  end
end
