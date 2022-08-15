# frozen_string_literal: true

set :environment, 'development'
set :output, 'log/cron.log'

every 1.minute do
  rake 'stories:delete_24_hours_old'
end
