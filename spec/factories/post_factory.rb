# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.define do
  factory :post do
    content { Faker::Quote.yoda }
    user
  end
end
