# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name

  menu priority: 4

  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :name
    actions
  end
end
