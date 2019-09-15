class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|
      t.attachment :slide
      t.references :container, foreign_key: true, index: true
      t.integer :position

      t.timestamps
    end
  end
end
