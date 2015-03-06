
namespace :gemsurance do
  desc 'Run Gemsurance'
  task :check do
    Bundler.with_clean_env do
      sh "gemsurance --format yml"
    end
  end
end
