set :output, '/var/log/flowfeeds/cron.log'
env :PATH, '/home/flowfeeds/.rbenv/shims:/home/flowfeeds/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:bin'

every 3.hours do
  rake "update"
end

every 1.day do
  rake "backup"
end
