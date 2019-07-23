# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'PixelCMS'
set :repo_url, 'gitolite@dev.ci2s.com.ar:pixelcms.git'



# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, "~/projects/PixelCMS"

# Default value for :scm is :git
 set :scm, :git
 set :user, 'bitnami'

 set :ssh_options, forward_agent: true

 set :deploy_via, :copy
 set :rails_env, 'production'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
 set :keep_releases, 5

namespace :deploy do

  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute 'cd ~/apps/PixelCMS && rvmsudo thin start  -C config/thin.yml'
    end
  end

  desc 'Start application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute 'cd ~/apps/PixelCMS && rvmsudo thin stop -C config/thin.yml'


    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:

      execute 'cd ~/apps/PixelCMS && rvmsudo thin restart -C config/thin.yml'

    end
  end

  after :publishing, :restart

  after :restart, :do_migrate do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
       within release_path do
         execute 'export RAILS_ENV=production'
         execute :rake, 'db:migrate'
       end
    end
  end

end
