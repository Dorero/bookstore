# frozen_string_literal: true

ActiveAdmin.register Category do
  index do
    selectable_column
    column :id
    column :name
  end

  filter :created_at
  filter :updated_at
end
