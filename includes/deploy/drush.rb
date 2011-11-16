namespace :drush do
  task :default do
  end

  desc "Drush cache clear"
  task :cc, :except => { :no_release => true } do
    domains.each do |domain|
      run "#{remote_drush} --uri=#{domain} cc all"
    end
  end


  namespace :web do
    desc "Set Drupal maintainance mode to online."
    task :enable do
      domains.each do |domain|
        php = 'variable_set("site_offline", FALSE)'
        run "#{remote_drush} --uri=#{domain} eval '#{php}'"
      end
    end

    desc "Set Drupal maintainance mode to off-line."
    task :disable do
      domains.each do |domain|
        php = 'variable_set("site_offline", TRUE)'
        run "#{remote_drush} --uri=#{domain} eval '#{php}'"
      end
    end
  end
  
  namespace :files do 
    desc "Create files backup"
    task :default do
      domains.each do |domain|
        dump_path = "#{shared_path}/files_backup/#{domain}"
        filename = "files_#{domain}_#{Time.now.to_i.to_s}.tar.bz2"
        run "mkdir -p #{dump_path}"
        run "cd #{shared_path}/#{domain}/files; tar cjf #{dump_path}/#{filename} *"
      end
    end
    
    desc "Download files backup"
    task :dl, :except => { :no_release => true } do
      drush::files::default
      domains.each do |domain|
         dump_path = "#{shared_path}/files_backup/#{domain}"         
         dumps = capture("ls -xt #{dump_path}").split.reverse
         get("#{dump_path}/#{dumps.last}", "./#{dumps.last}")
      end
    end
  end

  namespace :db do
    desc "Database backup"
    task :default, :except => { :no_release => true } do
      run "mkdir -p #{shared_path}/db_dumps/"
      domains.each do |domain|
        run "mkdir -p #{shared_path}/db_dumps/#{domain}"
        filename = "#{domain}_dump_#{Time.now.to_i.to_s}.sql"
        dump_path = "#{shared_path}/db_dumps/#{domain}"
        run "#{remote_drush} --uri=#{domain} sql-dump --structure-tables-key=common > #{dump_path}/#{filename}"
        run "cd #{dump_path}; bzip2 #{filename}"
      end
    end

   desc "Database Download backup"
    task :dl, :except => { :no_release => true } do
      drush::db::default
      domains.each do |domain|
         dump_path = "#{shared_path}/db_dumps/#{domain}"
         dumps = capture("ls -xt #{dump_path}").split.reverse
         get("#{dump_path}/#{dumps.last}", "./#{dumps.last}")
      end
    end
  end
  
end