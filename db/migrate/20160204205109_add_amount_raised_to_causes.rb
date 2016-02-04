class AddAmountRaisedToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :amount_raised, :integer, default: 0
  end
end
