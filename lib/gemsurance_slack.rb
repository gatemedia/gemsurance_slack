require "slack-notifier"
require "gemsurance"

require "gemsurance_slack/version"

module GemsuranceSlack
  class Engine < ::Rails::Engine
  end

  def self.check_and_notify
    abort "Error: environment variables SLACK_WEBHOOK_URL or SLACK_CHANNEL empty." unless initialize_slack_notifier

    @gems_infos = Gemsurance::Runner.new.build_gems_infos

    vulnerables_notification
    outdated_notification
  end

  private

  def self.initialize_slack_notifier
    webhook_url = ENV["SLACK_WEBHOOK_URL"]
    channel = ENV["SLACK_CHANNEL"]
    return false unless webhook_url && channel

    @notifier = Slack::Notifier.new webhook_url, :channel => channel
  end

  def self.vulnerables_notification
    vulnerables = @gems_infos.select(&:vulnerable?)
    return if vulnerables.empty?

    @notifier.ping "", :icon_emoji => ":rotating_light:", :username => "Gemsurance Alert", :attachments => [{
      :fallback => "#{project_name}, #{gems_count_string(vulnerables.count)} vulnerable.",
      :pretext => "#{project_name}, #{gems_count_string(vulnerables.count)} vulnerable.",
      :color => "danger",
      :fields => vulnerables.map do |gm|
        {
          :title => gm.name,
          :value => "Update v#{gm.current_version} to v#{gm.newest_version} (#{gm.vulnerabilities.map(&:title).join(", ")})",
          :short => false
        }
      end
    }]
  end

  def self.outdated_notification
    outdated = @gems_infos.select(&:outdated?)
    return if outdated.empty?

    @notifier.ping "", :icon_emoji => ":warning:", :username => "Gemsurance Warning", :attachments => [{
      :fallback => "#{project_name}, #{gems_count_string(outdated.count)} out of date.",
      :pretext => "#{project_name}, #{gems_count_string(outdated.count)} out of date.",
      :color => "warning",
      :fields => [{
        :title => outdated.map(&:name).join(", ")
      }]
    }]
  end

  def self.project_name
    ENV["SLACK_APP_NAME"] || ""
  end

  def self.gems_count_string(count)
    count == 1 ? "1 gem is" : "#{count} gems are"
  end
end
