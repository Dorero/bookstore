# frozen_string_literal: true

ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  includes(:author_books, :books)

  menu priority: 3

  filter :created_at
  filter :updated_at
  filter :first_name
  filter :last_name
  filter :books, as: :select, collection: proc { Book.all.map { |book| [book.name, book.id] } }

  show title: proc { |author| author.decorate.name } do
    attributes_table :first_name, :last_name, :description, :created_at, :updated_at
  end

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :description
    column :book, &:books
    actions
  end
end
