# frozen_string_literal: true

ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :description
  end

  filter :created_at
  filter :updated_at
end
