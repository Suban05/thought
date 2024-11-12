# frozen_string_literal: true

require 'bcrypt'

%w[Музыка Кино].each do |category|
  Category.create(name: category)
end

5.times do
  User.create(
    email: Faker::Internet.email,
    password: BCrypt::Password.create('password')
  )
end

5.times do
  Post.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph_by_chars(number: 500),
    category_id: (1..2).to_a.sample,
    creator_id: (1..5).to_a.sample
  )
end
