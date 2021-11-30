# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name

  menu priority: 4

  index do
    selectable_column
    column :id
    column :name
    column do |category|
      span link_to link_to I18n.t(:view_admin_button), admin_category_path(category)
      span link_to link_to I18n.t(:edit_admin_button), edit_admin_category_path(category)
      span link_to link_to I18n.t(:delete_admin_button), admin_category_path(category), method: :delete
    end
  end

  filter :created_at
  filter :updated_at
end
