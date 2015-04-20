# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemsurance_slack/version'

Gem::Specification.new do |spec|
  spec.name          = "gemsurance_slack"
  spec.version       = GemsuranceSlack::VERSION
  spec.authors       = ["Ben Colon"]
  spec.email         = ["ben@colon.com.fr"]
  spec.summary       = %q{Rake task to run Gemsurance and send gems alerts/warnings to Slack}
  spec.description   = %q{Rake task to run Gemsurance and send gems alerts/warnings to Slack}
  spec.homepage      = "https://github.com/gatemedia/gemsurance_slack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("gemsurance", "~> 0.6.0")
  spec.add_dependency("slack-notifier", "~> 1.1.0")

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
