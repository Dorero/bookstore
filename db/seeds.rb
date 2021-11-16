# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do
  name = Faker::Book.author.split(' ')
  author = Author.create(first_name: name.first, last_name: name.last)
  book = Book.create(name: Faker::Books::CultureSeries.book, description: Faker::Books::Lovecraft.paragraph,
                     image: 'http://jonathantweedy.com/resources/thumbs/SmashingBook5ResponsiveWebDesign.jpg',)
  AuthorBook.create(author: author, book: book)
end



