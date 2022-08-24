# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.define do
  factory :comment do
    body { Faker::Quote.yoda }
    post
    user
  end
end
