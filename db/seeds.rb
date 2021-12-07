# frozen_string_literal: true

Category.create(name: 'Mobile development')
Category.create(name: 'Photo')
Category.create(name: 'Web design')

10.times do |index|
  file = File.new(Rails.root.join('app/assets/images/seed/SmashingBook5ResponsiveWebDesign.jpg'))
  uploaded_file = ImageUploader.new(:store).upload(file)
  author = Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, description: FFaker::Book.description)
  book = Book.create(name: FFaker::Book.title, description: FFaker::Book.description,
                     category_id: rand(3) + 1, price: rand(11.2...76.9).round(2), year: rand(500) + 1521,
                     height: rand(1.0...10.9).round(2), width: rand(1.0...6.9).round(2), depth: rand(1.0...5.0).round(2),
                     materials: FFaker::Product.product)

  image = Image.new(image_data: uploaded_file.to_json, book: book)
  image.image_derivatives!
  image.save

  AuthorBook.create(author: author, book: book)
  user = User.new(email: FFaker::Internet.email, password: '123QWEasd' ,first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, encrypted_password: FFaker::Internet.password)
  user.skip_confirmation!
  user.save!

  Review.create(title: FFaker::Book.title, message: FFaker::Book.description, user: user, book: book, stars: rand(5) + 1)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
