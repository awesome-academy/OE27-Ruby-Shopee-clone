require "resque/scheduler"
require "resque/scheduler/server"

redis_configs = Rails.configuration.database_configuration[Rails.env]["redis"]
Resque.redis = Redis.new redis_configs
Resque.redis.namespace = "resque:AsyncDownload"

# If you want to be able to dynamically change the schedule,
# uncomment this line.  A dynamic schedule can be updated via the
# Resque::Scheduler.set_schedule (and remove_schedule) methods.
# When dynamic is set to true, the scheduler process looks for
# schedule changes and applies them on the fly.
# Note: This feature is only available in >=2.0.0.
# Resque::Scheduler.dynamic = true

Dir[Rails.root.join("app", "jobs", "*.rb")].each{|file| require file}
