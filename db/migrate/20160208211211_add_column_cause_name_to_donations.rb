class AddColumnCauseNameToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :cause_name, :string
  end
end
