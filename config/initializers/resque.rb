require "resque/scheduler"
require "resque/scheduler/server"

redis_configs = Rails.configuration.database_configuration[Rails.env]["redis"]
Resque.redis = Redis.new redis_configs
Resque.redis.namespace = "resque:AsyncDownload"

Dir[Rails.root.join("app", "jobs", "*.rb")].each{|file| require file}
