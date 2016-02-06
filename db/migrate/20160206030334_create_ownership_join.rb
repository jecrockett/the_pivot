class CreateOwnershipJoin < ActiveRecord::Migration
  def change
    create_table :ownership_joins do |t|
      t.references :cause, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :role, default: 0
    end
  end
end
