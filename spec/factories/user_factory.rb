# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.define do
  factory :user do
    fullname { Faker::Name.name }
    bio { Faker::Quote.yoda }
    is_private { Faker::Boolean.boolean }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
