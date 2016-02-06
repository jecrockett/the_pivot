class AddStatusToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :status, :integer, default: 0
  end
end
