class AddPaymentToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :payment, null: true
  end
end
