class AddDeliveryToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :delivery
  end
end
