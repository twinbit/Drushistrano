Drushistrano
====================

When Drupal and Drush meets Capistrano
--------------------------------------


### Initialize the project - cap staging deploy:setup
	    paolo ~/webapps/drushistrano $ cap staging deploy:setup
	      * executing `staging'
	      * executing `deploy:setup'
	      * executing "mkdir -p /var/apps/app1 /var/apps/app1/releases /var/apps/app1/shared /var/apps/app1/shared/system /var/apps/app1/shared/log /var/apps/app1/shared/pids &&  chmod g+w /var/apps/app1 /var/apps/app1/releases /var/apps/app1/shared /var/apps/app1/shared/system /var/apps/app1/shared/log /var/apps/app1/shared/pids"
	        servers: ["188.40.59.145"]
	        [188.40.59.145:8888] executing command
	        command finished
	        triggering after callbacks for `deploy:setup'
	      * executing `drupal:setup'
	      * executing "umask 02 && mkdir -p /var/apps/app1 /var/apps/app1/releases /var/apps/app1/shared /var/apps/app1/shared/default/files /var/apps/app1/shared/system"
	        servers: ["188.40.59.145"]
	        [188.40.59.145:8888] exe


### File Structure after a deploy:setup
	  root@gilda /var/apps # cd app1/
	  root@gilda /var/apps/app1 # ls -al
	  total 16
	  drwxrwxr-x  4 deploy deploy 4096 2011-10-18 00:35 .
	  drwxr-xr-x 10 deploy deploy 4096 2011-10-18 00:35 ..
	  drwxrwxr-x  2 deploy deploy 4096 2011-10-18 00:35 releases
	  drwxrwxr-x  6 deploy deploy 4096 2011-10-18 00:35 shared
	  root@gilda /var/apps/app1 # cd shared/
	  root@gilda /var/apps/app1/shared # ls -al
	  total 24
	  drwxrwxr-x 6 deploy deploy 4096 2011-10-18 00:35 .
	  drwxrwxr-x 4 deploy deploy 4096 2011-10-18 00:35 ..
	  drwxrwxr-x 3 deploy deploy 4096 2011-10-18 00:35 default
	  drwxrwxr-x 2 deploy deploy 4096 2011-10-18 00:35 log
	  drwxrwxr-x 2 deploy deploy 4096 2011-10-18 00:35 pids
	  drwxrwxr-x 2 deploy deploy 4096 2011-10-18 00:35 system
	  root@gilda /var/apps/app1/shared # cd default/
	  root@gilda /var/apps/app1/shared/default # ls -al
	  total 12
	  drwxrwxr-x 3 deploy deploy 4096 2011-10-18 00:35 .
	  drwxrwxr-x 6 deploy deploy 4096 2011-10-18 00:35 ..
	  drwxrwxr-x 2 deploy deploy 4096 2011-10-18 00:35 files
