# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: 'Mobile development')
Category.create(name: 'Photo')
Category.create(name: 'Web design')

30.times do
  author = Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, description: FFaker::Book.description)
  book = Book.create(name: FFaker::Book.title, description: FFaker::Book.description,
                     image: 'http://jonathantweedy.com/resources/thumbs/SmashingBook5ResponsiveWebDesign.jpg',
                     category_id: rand(3) + 1, price: rand(11.2...76.9).round(2), year: rand(500) + 1521,
                     height: rand(1.0...10.9).round(2), width: rand(1.0...6.9).round(2), depth: rand(1.0...5.0).round(2),
                     materials: FFaker::Product.product)
  AuthorBook.create(author: author, book: book)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
