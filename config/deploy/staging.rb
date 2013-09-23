set :deploy_to, "/home/#{user}/apps/#{application}"
set :rails_env, :staging
set :branch, 'master'

#set :nginx_binary, '/opt/nginx/sbin/nginx'

# elb_hosts=CapistranoElbFinder.list_deploy_hosts("staging")

#if (elb_hosts.empty?)
role :web, 'ec2-54-221-63-127.compute-1.amazonaws.com' # Your HTTP server, Apache/etc
#else
#  role :web, 'ec2-23-20-102-164.compute-1.amazonaws.com', *elb_hosts # Your main web server together with ELB instances
#end

role :app, 'ec2-54-221-63-127.compute-1.amazonaws.com'                   # This may be the same as your `Web` server
role :db,  'ec2-54-221-63-127.compute-1.amazonaws.com', :primary => true # This is where Rails migrations will run
role :central, 'ec2-54-221-63-127.compute-1.amazonaws.com'

#before 'deploy:update_code', 'deploy:suspend_monitoring'
# after 'deploy:update_code', 'deploy:update_shared_symlinks'
# after 'deploy:restart', 'foreman:export' # Update all the ec2 instances
# after 'foreman:export', 'foreman:restart' # Update all the ec2 instances
#after 'foreman:restart','deploy:activate_monitoring'
#after 'deploy:rollback','deploy:activate_monitoring'

require 'bundler/capistrano'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :web, :except => { :no_release => true } do
    roles[:web].servers.each do |server|
      #This way nginx pre-starts our application (if configured). Cannot achieve that by just restarting Passenger
      #run "#{sudo} #{nginx_binary} -s reload", :hosts => server.host
      run "touch #{release_path}/tmp/restart.txt"
    end
  end

  task :update_shared_symlinks do
    %w(config/evaluations_database.yml config/database.yml config/s3.yml config/s3tmp.yml config/site_counts_emr.yml config/tracking_dynamodb.yml config/google_api_client.yml config/related_contents_emr.yml config/zencoder.yml).each do |path|
      run "ln -s #{File.join(deploy_to, "shared", path)} #{File.join(release_path, path)}"
    end
  end

  task :suspend_monitoring do
    run_locally "bundle exec rake aws:suspend_monitoring RAILS_ENV=#{rails_env}"
  end

  task :activate_monitoring do
    run_locally "bundle exec rake aws:activate_monitoring RAILS_ENV=#{rails_env}"
  end

end

# Foreman tasks
# http://blog.sosedoff.com/2011/07/24/foreman-capistrano-for-rails-3-applications/
namespace :foreman do
  desc 'Export the Procfile to Ubuntu upstart scripts'
  task :export, :roles => :app do
    run "cd #{release_path} && rvmsudo bundle exec foreman export upstart /etc/init -a #{worker_name} -u #{user} -l #{release_path}/log/foreman"
  end

  desc 'Start the application services'
  task :start, :roles => :app do
    sudo "start #{worker_name}"
  end

  desc 'Stop the application services'
  task :stop, :roles => :app do
    sudo "stop #{worker_name}"
  end

  desc 'Restart the application services'
  task :restart, :roles => :app do
    run "sudo start #{worker_name} || sudo restart #{worker_name}"
  end
end
