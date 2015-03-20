# GemsuranceSlack

Rake task to run Gemsurance and send gems alerts/warnings to Slack

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

```
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
SLACK_CHANNEL="#mychannel"
SLACK_APP_NAME="My application name"
```

## Usage

You can manually run `rake gemsurance_slack:check` in your project.

If everything is well setup, you should receive Gemsurance warnings/alerts in your Slack channel.

## Heroku setup

To be daily inform about your project gems status running on Heroku,

1. set Slack config variables

  ```
  heroku config:set SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
  heroku config:set SLACK_CHANNEL="#mychannel"
  heroku config:set SLACK_APP_NAME="My application name"
  ```

2. add the Heroku scheduler addon and open it

  ```
  heroku addons:add scheduler:standard
  heroku addons:open scheduler
  ```

3. add a job, set the task with `rake gemsurance_slack:check`, select the frequency and save.

  Now you'll be periodically inform in your Slack channel about your project gems status.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gemsurance_slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

