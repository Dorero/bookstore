class AddRelationsToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :place, polymorphic: true
    add_reference :addresses, :order, foreign_key: true
  end
end
