# files
require_relative '../lib/slack/slack'

# gems
require 'rspec'

# config
RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end