# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :name, :description, :image, :category_id, :price, :year, :height, :width, :depth, :materials, :book

  menu priority: 2

  includes(:category, :authors, :author_books, :images)

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
    column :image do |book|
      book.images.map { |image| image_tag image.image(:small).url }
    end

    column :category
    column :price
    column :author do |book|
      book.authors.map { |author| link_to(author.decorate.name, admin_author_path(author.id)) }
    end

    column do |book|
      span link_to link_to I18n.t(:view_admin_button), admin_book_path(book)
      span link_to link_to I18n.t(:edit_admin_button), edit_admin_book_path(book)
      span link_to link_to I18n.t(:delete_admin_button), admin_book_path(book), method: :delete
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file
    end

    f.actions
  end

  controller do
    def create
      book = Book.create(params_book)
      Image.create(image: params_image[:image], book: book)
      redirect_to admin_books_path, alert: I18n.t(:book_success_created)
    end

    private

    def params_book
      params.require(:book).except(:image).permit(:name, :description, :year, :height, :price, :width, :depth,
                                                  :materials, :category_id)
    end

    def params_image
      params.require(:book).permit(:image)
    end
  end
end
