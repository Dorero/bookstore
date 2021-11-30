# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :name, :description, :image, :category_id, :price

  menu priority: 2

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

    column do |book|
      span link_to link_to I18n.t(:view_admin_button), admin_book_path(book)
      span link_to link_to I18n.t(:edit_admin_button), edit_admin_book_path(book)
      span link_to link_to I18n.t(:delete_admin_button), admin_book_path(book), method: :delete
    end
  end

  filter :name
  filter :price
  filter :created_at
  filter :updated_at
  filter :category
  filter :authors, as: :select, collection: Author.all.map { |author|
                                              ["#{author.first_name} #{author.last_name}", author.id]
                                            }

  includes(:category, :authors, :author_books)
end
