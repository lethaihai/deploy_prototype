lock "~> 3.11.0"

set :application, "prototype"
set :repo_url, "git@github.com:lethaihai/deploy_prototype.git"
set :bundle_binstubs, nil

# Default branch is :master
set :branch, "develop"

set :deploy_to, "/var/www/html/#{fetch(:application)}"

set :linked_files, fetch(:linked_files, [])
  .push("config/database.yml", "config/secrets.yml")
set :linked_dirs, fetch(:linked_dirs, [])
  .push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle")

set :keep_releases, 5

after "deploy:publishing", "deploy:restart"

# Khởi động lại unicorn sau khi deploy
namespace :deploy do

  desc "create database"
  task :create_database do
    on roles(:db) do |host|
      within "#{release_path}" do
        with rails_env: ENV["staging"] do
          execute :rake, "RAILS_ENV=staging db:create"
        end
      end
    end
  end
  before :migrate, :create_database

  task :restart do
    invoke "unicorn:restart"
  end
end
