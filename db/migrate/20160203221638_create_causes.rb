class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.integer :goal

      t.timestamps null: false
    end
  end
end
