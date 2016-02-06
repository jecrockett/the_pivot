class AddOtherAdminsToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :other_admins, :string, array: true, default: []
  end
end
