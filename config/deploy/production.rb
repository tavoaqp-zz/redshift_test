# -*- coding: utf-8 -*-
set :rails_env, :production
set :branch, 'production'
set :application, 'media-choice'
set :worker_name, 'productionclipes'

#set :nginx_binary, '/opt/nginx/sbin/nginx'

#FIXME: Comentei as linhas porque o load balancer associado ao grupo de autoscale não existe no Clipes e Bandas
#elb_hosts=CapistranoElbFinder.list_deploy_hosts("production", "central.clipesebandas.com.br")
#if (elb_hosts.empty?)
  role :web, 'central.clipesebandas.com.br' # Our web server central instance
#else
#  role :web, 'central.clipesebandas.com.br', *elb_hosts # Our web server central instance plus ELB instances
#end

role :app, 'central.clipesebandas.com.br','julgamento.clipesebandas.com.br' # We hold a web server and a job server
role :db,  'central.clipesebandas.com.br', :primary => true # This is where Rails migrations will run
role :crontab, 'julgamento.clipesebandas.com.br' # This is where crontab jobs will run

before 'deploy:update_code', 'deploy:cleanup' 
after 'deploy:update_code', 'deploy:git_housekeeping'
after 'deploy:git_housekeeping', 'deploy:update_shared_symlinks'
after 'deploy:restart', 'foreman:export'                          # Export foreman scripts
after 'foreman:export', 'foreman:restart'                         # Restart application scripts
after 'foreman:restart', 'deploy:update_crontab' # Update all the ec2 instances

require 'bundler/capistrano'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :web, :except => { :no_release => true } do
    #This way nginx pre-starts our application (if configured). Cannot achieve that by just restarting Passenger
    #run "#{sudo} #{nginx_binary} -s reload"
    run "touch #{release_path}/tmp/restart.txt"
  end
  
  task :update_shared_symlinks do
    %w(config/database.yml config/s3.yml config/s3tmp.yml config/site_counts_emr.yml config/tracking_dynamodb.yml config/evaluations_database.yml config/related_contents_emr.yml config/google_api_client.yml config/zencoder.yml).each do |path|
      run "ln -s #{File.join(deploy_to, "shared", path)} #{File.join(release_path, path)}"
    end
  end
  
  task :update_crontab, :roles => :crontab do
    run "cd #{release_path} && /usr/bin/env bundle exec whenever -i #{worker_name} -s'environment=production' RAILS_ENV=#{rails_env}"
  end

  task :git_housekeeping, :roles => [:web, :crontab] do
    run "cd #{release_path} ; git gc"
  end  
end

# Foreman tasks
# http://blog.sosedoff.com/2011/07/24/foreman-capistrano-for-rails-3-applications/
namespace :foreman do
  desc 'Export the Procfile to Ubuntu upstart scripts'
  task :export, :roles => :crontab do
    run "cd #{release_path} && rvmsudo bundle exec foreman export upstart /etc/init -a #{worker_name} -u #{user} -l #{release_path}/log/foreman -c emailworker=1,worker=1"
  end

  desc 'Start the application services'
  task :start, :roles => :crontab do
    sudo "start #{worker_name}"
  end

  desc 'Stop the application services'
  task :stop, :roles => :crontab do
    sudo "stop #{worker_name}"
  end

  desc 'Restart the application services'
  task :restart, :roles => :crontab do
    run "sudo start #{worker_name} || sudo restart #{worker_name}"
  end
end

