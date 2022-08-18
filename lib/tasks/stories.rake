# frozen_string_literal: true

namespace :stories do
  desc 'Delete stories older than 24 hours'
  task delete_24_hours_old: :environment do
    Story.where(['created_at < ?', 24.hours.ago]).destroy_all
  end
end
