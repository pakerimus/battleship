class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.references :player, index: true, foreign_key: true
      t.string :cell
      t.string :result

      t.timestamps null: false
    end
  end
end
