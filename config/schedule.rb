set :output, '/var/log/flowfeeds/cron.log'

every 3.hours do
  rake "update"
end

every 1.day do
  rake "backup"
end
