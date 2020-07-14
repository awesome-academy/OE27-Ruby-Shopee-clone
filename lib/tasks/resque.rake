require "resque/tasks"
require "resque/scheduler/tasks"

namespace :resque do
  desc "TODO"
  task setup: :environment do
    ENV["QUEUE"] = "*"
  end
end
