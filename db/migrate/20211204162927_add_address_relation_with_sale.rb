class AddAddressRelationWithSale < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :sale
  end
end
