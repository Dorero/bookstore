# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :name, :description, :image, :category_id, :price, author_books_ids: []

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :image
    column :category
    column :price
    column :author do |book|
      book.authors.map { |author| link_to("#{author.first_name} #{author.last_name}", admin_author_path(author.id)) }
    end
  end

  filter :name
  filter :price
  filter :created_at
  filter :updated_at
  filter :category

  includes(:category, :authors, :author_books)
end
