desc "deploy to production environment"
task :development do
  set :stage_name, "development"
  set :application, "#APPLICATION_NAME#"
  # we should use an absolute path (tilde is not admitted by sftp - https://groups.google.com/d/msg/capistrano/CCAfCsN-o80/AnvxU4MW3OIJ)
  set :deploy_to,  "/var/apps/#{application}"
  
  # Remote GIT repository (ex: git://github.com/drupal/drupal.git)
  set :repository,  "#REMOTE_GIT_PATH#"
  set :branch, "master"
  
  # Remote WEB [IP|HOST][:PORT] (ex: 127.0.0.1:8888 or twinbitlabs.com:8888)
  role :web, "#REMOTE_SERVER_IP[:PORT]#", :primary => true
  # Remote DBMS SERVER [IP|HOST][:PORT] (ex: 127.0.0.1:8888 or twinbitlabs.com:8888)
  role :db, "#REMOTE_SERVER_IP[:PORT]#", :primary => true, :no_release => true

  # Remote Drush override 
  #set :remote_drush, "cd #{current_path}; sudo /home/deploy/bin/drush"

  # SSH Configurations (user, pass) (is highly suggested to use ssh key authentication)
  set :user, "deploy"
#  set :pass, 'deploy'

  # Forward local ssh keys.
  ssh_options[:forward_agent] = true
  set :use_sudo, false

  # Drupal domains to deploy (keep "default" domain or at least one domain to use)
  # Ex: "sites/all/app1 sites/all/app2" --> set :domains, ["app1", "app2"]
  set :domains, ["default"]
  
  # Specify which domain needs to be used as default (optional)
  # This is useful for single site environment to have a different default dir rather than standard "default" dir
  # Ex: set :default_domain, "app1"
  #set :default_domain, ""
  
  # create virtual host symlinks
  #set :virtual_host, ["app1.test.com"]
end
