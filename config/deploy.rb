require 'bundler/capistrano'

server 'flowfeeds.com', :web, :app, :db, primary: true

set :application, "flowfeeds"
set :user,        "flowfeeds"
set :deploy_to,   "/home/#{user}/"
set :deploy_via,  :remote_cache
set :use_sudo,    false

set :scm, "git"
set :repository, "git@github.com:nerdyworm/flowfeeds.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :bundle_cmd, "/home/#{user}/.rbenv/shims/bundle"
set :bundle_flags, "--quiet"

after "deploy", "deploy:cleanup"
namespace :deploy do
  desc "Resart the unicorn application server with upgrade"
  task :restart, :roles => :app, except: { no_release: true } do
    run "sudo restart #{application}"
  end

  desc 'Exports the forman Profile to an init tab'
  task :foreman, :roles => :app, except: { no_release: true } do
    run "cd #{current_path} && sudo foreman export upstart /etc/init -a #{application} -u #{user}"
  end

  desc 'Update crontab'
  task :crontab, :roles => :app, except: { no_release: true } do
    run "cd #{current_path} && #{bundle_cmd} exec whenever --update-crontab #{application}"
  end

  desc 'Copy the ENV variables'
  task :env, roles: :app, except: { no_release: true } do
    run "cp /home/#{user}/.env #{current_path}"
  end

  desc "Copy resque-web assets into public folder"
  task :copy_resque_assets do
    target = File.join(release_path,'public','admin', 'resque')
    run "mkdir -p #{target}"
    run "cp -r `cd #{release_path} && bundle show resque`/lib/resque/server/public/* #{target}"
  end
end

after  'deploy:update_code', 'deploy:migrate'
after  'deploy:update',  'deploy:cleanup'

before 'deploy:restart', 'deploy:foreman', 'deploy:env'
after  'deploy:restart', 'deploy:crontab', 'deploy:copy_resque_assets'

