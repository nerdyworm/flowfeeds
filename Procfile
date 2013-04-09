web: source .env && /home/flowfeeds/.rbenv/shims/bundle exec unicorn -c /home/flowfeeds/current/config/unicorn.rb
worker: source .env && QUEUES=* /home/flowfeeds/.rbenv/shims/bundle exec rake resque:work
