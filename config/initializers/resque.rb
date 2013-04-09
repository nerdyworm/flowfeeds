require 'resque/server'

Resque.redis = YAML.load_file("config/resque.yml")[Rails.env.to_s]
