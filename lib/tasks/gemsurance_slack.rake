#require 'gemsurance_slack'

namespace :gemsurance_slack do
  desc 'Run Gemsurance'
  task :check do
    GemsuranceSlack.check_and_notify
  end
end
