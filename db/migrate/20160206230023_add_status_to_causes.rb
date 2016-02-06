class AddStatusToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :current_status, :string, default: 'pending'
  end
end
