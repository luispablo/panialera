$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require "bundler/capistrano"

set :application, "panialera"
set :repository,  "git@github.com:luispablo/panialera.git"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
set :branch, 'master'
set :scm_verbose, true

set :rails_env, :production

set :deploy_to, "/opt/apps/panialera"

server "li506-126.members.linode.com", :app, :web, :db, :primary => true

# adjust if you are using RVM, remove if you are not
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system

# Usuario para loguearse a linode.com
set :user, "luispablo"
# Usuario para trabajar con github
set :scm_username, "luispablo"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do

	desc "cause Passenger to initiate a restart"
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	end

	desc "reload the database with seed data"
	task :seed do
		run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
	end   	
 end
 
after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install do
	run "cd #{release_path} && bundle install"
end
