# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :name, :description, :image, :category_id, :price

  includes(:category, :authors, :author_books)

  menu priority: 2

  filter :name
  filter :price
  filter :created_at
  filter :updated_at
  filter :category
  filter :authors, as: :select, collection: proc {
    Author.all.map do |author|
      [author.decorate.name, author.id]
    end
  }

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :image
    column :category
    column :price
    column :author do |book|
      book.authors.map { |author| link_to(author.decorate.name, admin_author_path(author.id)) }
    end

    actions
  end
end
