set :user, 'synthetica'
set :domain, "synthetica.com.au"
set :application, "HearClear"
set :repository,  "git@github.com:dannolan/hearclear-backend.git"

set :scm, :git
set :branch, "master"

set :deploy_to, "/home/#{user}/hearclear.mobi"

require "bundler/capistrano"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


default_run_options[:pty] = true
ssh_options[:forward_agent] = true


role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
	run "cd #{deploy_to}/current && sudo bundle install"
	run "test -d #{current_path}/log || mkdir #{current_path}/log"
	run "cd #{deploy_to}/current/tmp && touch restart.txt"
	#run "sudo /etc/init.d/nginx stop"
	#run "sudo /etc/init.d/nginx start"
	end
	task :cold do
		deploy.update
		deploy.start
	end
end

after "deploy:restart", "deploy:cleanup"


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end