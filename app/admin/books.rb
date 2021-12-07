# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :name, :description, :category_id, :image, :price, :year, :height, :width, :depth, :materials, :book,
                images_attributes: %i[id image book_id _destroy]

  includes(:category, :authors, :author_books, :images)

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
    column :images do |book|
      book.images.map { |image| image_tag image.image(:small)&.url }
    end

    column :category
    column :price
    column :author do |book|
      book.authors.map { |author| link_to(author.decorate.name, admin_author_path(author.id)) }
    end

    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.has_many :images do |ff|
      ff.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table :name, :description, :category_id, :price, :year, :height, :width, :depth, :materials do
      row :images do
        book.images.map { |image| image_tag image.image(:small)&.url }
      end
    end
  end
end
