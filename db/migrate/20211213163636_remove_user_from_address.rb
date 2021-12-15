class RemoveUserFromAddress < ActiveRecord::Migration[6.1]
  def change
    remove_reference :addresses, :user
  end
end
