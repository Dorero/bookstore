class AddRelationsToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :addressed, polymorphic: true, foreign_key: true
  end
end
