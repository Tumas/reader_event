require "rvm/capistrano"

set :rvm_ruby_string, 'ruby-1.9.3-p194'

require 'bundler/capistrano'

server "?", :app, :web, :db, :primary => true

default_run_options[:pty] = true

set :application, "reader_event"
set :user, 'deployer'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache 
set :use_sudo, false 

set :scm, 'git'
set :repository, "https://github.com/Tumas/reader_event.git"
set :branch, 'master'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Hot-reload God configuration for the Resque worker"
  task :reload_god_config do
    sudo "god stop resque"
    sudo "god load #{File.join(deploy_to, 'current', 'config', 'resque-' + rails_env + '.god')}"
    sudo "god start resque"
  end
end
 
after "deploy:restart", "deploy:cleanup" 
after :deploy, "deploy:reload_god_config"