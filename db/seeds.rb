# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ['Leon', 'Jason', 'Mike', 'Michael', 'Ursula', 'Vadim', 'Rob', 'Oleg']


10.times do
  author = Author.create(first_name: "Author ##{rand(10)}", last_name: "#{names[rand(names.length )]}")
  book_id = rand(10)
  book = Book.create(name: "Book ##{book_id}", description: "describe book ##{book_id}",
                     image: 'http://jonathantweedy.com/resources/thumbs/SmashingBook5ResponsiveWebDesign.jpg',)
  Publisher.create(author: author, book: book)
end



