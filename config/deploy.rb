set :stages, %w(production staging)
set :default_stage, "staging"
set :keep_releases, 3
require 'capistrano/ext/multistage'
require 'capistrano/confirm'
require "rvm/capistrano"                               # Load RVM's capistrano plugin.

set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3-p194@redshift'   # Or whatever env you want it to run in.
set :rvm_bin_path, '/usr/local/rvm/bin'

default_run_options[:pty] = true   # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true # Use local keys instead of the ones on the server

set :application, 'admin_geo'
set :rails_root, %x['pwd']

set :repository, 'git@github.com:tavoaqp/redshift_test.git'
set :scm, :git
#set :git_enable_submodules, 1
set :scm_verbose, false
#set :deploy_via, :remote_cache

set :keep_releases, 3
after "deploy", "deploy:cleanup"

set :user, 'ubuntu'
set :use_sudo, false
set :deploy_to, "/home/#{user}/apps/#{application}"
set :confirm_stages, "staging"
