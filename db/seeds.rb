# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
Category.create(name: 'Mobile development')
Category.create(name: 'Photo')
Category.create(name: 'Web design')

10.times do
  name_author = Faker::Book.author.split(' ')
  user = User.create(name: Faker::Artist.name)
  author = Author.create(first_name: name_author.first, last_name: name_author.last)
  book = Book.create(name: Faker::Book.title, description: Faker::Books::Lovecraft.paragraph,
                     image: 'http://jonathantweedy.com/resources/thumbs/SmashingBook5ResponsiveWebDesign.jpg',
                     category_id: rand(3) + 1, price: rand(11.2...76.9).round(2))
  Publisher.create(author: author, book: book)
  UserBook.create(user: user, book: book)
end

