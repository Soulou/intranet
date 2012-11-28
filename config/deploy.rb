require 'bundler/capistrano'

set :application, "ensiie-intranet"
set :repository,  "ssh://git@ares-ensiie.eu:2222/ensiie_intranet.git"
set :scm, :git
set :user, "intranet"
set :password, "vohitjocji"
set :branch, "master"
set :use_sudo, false
set :deploy_to, "/home/intranet/"

set :default_environment, {
    'PATH' => "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
}

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "ares-ensiie.eu:2201", :app, :web, :db, :primary => true

# role :web, "ares-ensiie.eu:2201"                          # Your HTTP server, Apache/etc
# role :app, "ares-ensiie.eu:2201"                          # This may be the same as your `Web` server
# role :db,  "ares-ensiie.eu:2201", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do 
     run "rails s --pid=server.pid -d --port 8081"
   end
   task :stop do
     run "kill -9 `cat server.pid`"
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "kill -9 `cat current/tmp/pids/server.pid`"
     run "cd current ; rails s -d --port=8081"
   end
 end
