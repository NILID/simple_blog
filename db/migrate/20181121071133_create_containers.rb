class CreateContainers < ActiveRecord::Migration[5.0]
  def change
    create_table :containers do |t|
      t.text :content, default: nil
      t.references :note, foreign_key: true, null: false, index: true
      t.string :types_mask, null: false
      t.integer :position

      t.timestamps
    end
  end
end
