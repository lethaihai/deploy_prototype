set :user, "root"
set :deploy_via, :remote_cache
set :conditionally_migrate, true
set :rails_env, "staging"

# Phần IP thì bạn thay thế cho phù hợp với IP của Docker container nhé
server "172.17.0.2", user: fetch(:user), port: fetch(:port), roles: %w(web app db)
