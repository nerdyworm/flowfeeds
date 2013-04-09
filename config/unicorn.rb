rails_env = 'production'

# Spanw this many workers
worker_processes 2

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Listen on a Unix data socket
listen '/home/flowfeeds/shared/unicorn.sock', backlog: 2048
