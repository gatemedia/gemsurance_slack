# GemsuranceSlack

Rake task to run [Gemsurance](https://github.com/appfolio/gemsurance) and send gems alerts/warnings to [Slack](https://slack.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemsurance_slack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gemsurance_slack

Don't forget to set Slack settings environment variables into your project

```bash
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
SLACK_CHANNEL="#mychannel"
SLACK_APP_NAME="My application name"
```

## Usage

You can manually run `rake gemsurance_slack:check` in your project.

If everything is well setup, you should receive Gemsurance warnings/alerts in your Slack channel.

## Slack notifications example

![Slack notifications example](https://raw.github.com/gatemedia/gemsurance_slack/master/images/notifications.png)

## Heroku scheduler setup

To be daily inform about your project gems status running on Heroku,

1. set Slack config variables

  ```bash
  heroku config:set SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
  heroku config:set SLACK_CHANNEL="#mychannel"
  heroku config:set SLACK_APP_NAME="My application name"
  ```

2. add the Heroku scheduler addon and open it

  ```bash
  heroku addons:add scheduler:standard
  heroku addons:open scheduler
  ```

3. add a job, set the task with `rake gemsurance_slack:check`, select the frequency and save.

  Now you'll be periodically inform in your Slack channel about your project gems status.

## Clockwork setup

If you're using the scheduling gem [Clockwork](https://github.com/tomykaira/clockwork), you just have to add this line in your clockwork config file.

```ruby
every(1.day, 'Check gems status', :at => '00:30') { GemsuranceSlack.check_and_notify }
```

## Cron setup

For a daily check at midnight by using Cron, edit your crontab file and add this line :

```bash
00 00 * * * cd /Users/you/projects/myrailsapp && /usr/local/bin/rake RAILS_ENV=production gemsurance_slack:check
```

## Contributing

1. Fork it ( https://github.com/gatemedia/gemsurance_slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

