# frozen_string_literal: true

ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  menu priority: 3

  show title: proc { |author| "#{author.first_name} #{author.last_name}" } do
    attributes_table :first_name, :last_name, :description, :created_at, :updated_at
    active_admin_comments
  end

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :description
    column :book, &:books

    column do |author|
      span link_to link_to I18n.t(:view_admin_button), admin_author_path(author)
      span link_to link_to I18n.t(:edit_admin_button), edit_admin_author_path(author)
      span link_to link_to I18n.t(:delete_admin_button), admin_author_path(author), method: :delete
    end
  end

  filter :created_at
  filter :updated_at
  filter :first_name
  filter :last_name
  filter :books, as: :select, collection: Book.all.map { |book| [book.name, book.id] }

  includes(:author_books, :books)
end