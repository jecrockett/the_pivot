class AddUserReferencesToCauses < ActiveRecord::Migration
  def change
    add_reference :causes, :user, index: true, foreign_key: true
  end
end
