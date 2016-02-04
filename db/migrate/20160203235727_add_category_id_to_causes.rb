class AddCategoryIdToCauses < ActiveRecord::Migration
  def change
    add_reference :causes, :category, index: true, foreign_key: true
  end
end
