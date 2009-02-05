set :application, "sir2.0"
set :repository,  "git://github.com/volomir/sir.git"
set :scm, "git"
set :git_enable_submodules, 1


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/isabel/sir2.0"
set :deploy_via, :export

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

after 'deploy:update_code', 'deploy:link_files'
after 'deploy:update_code', 'deploy:fix_file_permissions'

namespace(:deploy) do
  task :fix_file_permissions do
    # AttachmentFu dir is deleted in deployment
    run  "/bin/mkdir -p #{ release_path }/tmp/attachment_fu"
    run "/bin/chmod -R g+w #{ release_path }/tmp"
    run "/bin/chgrp -R www-data #{ release_path }/tmp"
  end

  task :link_files do
    run "ln -sf #{ shared_path }/config/database.yml #{ release_path }/config/"
  end

  desc "Restarting mod_rails with restart.txt"
    task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


role :app, "root@flexsir.dit.upm.es"
role :web, "root@flexsir.dit.upm.es"
role :db,  "root@flexsir.dit.upm.es", :primary => true
