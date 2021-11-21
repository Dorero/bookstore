FactoryBot.define do
  factory :user do
    email { FFaker::Internet.disposable_email }
    first_name { FFaker::Name.first_name}
    last_name { FFaker::Name.last_name}
    image { FFaker::Image.url}
    password { FFaker::Internet.password}
    reset_password_token { FFaker::Internet.password}
  end
end
