require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p194'

require 'bundler/capistrano'

server "XXX.XXX.XX.XXX", :app, :web, :db, :primary => true

set :application, "reader_event"
set :user, 'deployer'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache 
set :use_sudo, false 

set :scm, 'git'
set :repository, "https://github.com/Tumas/reader_event.git"
set :branch, 'master'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
