# environment variables
# require 'dotenv'
# Dotenv.load

# gems
require 'httparty'

# TODO: ENV
class Slack
  class << self

    # an alias for ENV['SLACK_TOKEN']
    def token
      ENV['SLACK_TOKEN']
    end
    
    def test
      HTTParty.post("https://slack.com/api/auth.test?token=#{Slack.token}")
    end

    def message(channel, text)
      HTTParty.post("https://slack.com/api/chat.postMessage?token=#{Slack.token}&channel=#{channel}&text=#{text}&username=virgil&as_user=true")
    end

    def channel_list
      HTTParty.post("https://slack.com/api/channels.list?token=#{Slack.token}")
    end

    def rtm
      HTTParty.post("https://slack.com/api/rtm.start?token=#{Slack.token}") 
    end

    def find_user_name(id)
      resp = HTTParty.post("https://slack.com/api/users.info?token=#{Slack.token}&user=#{id}")
      return 'Philistine' if resp.nil?
      resp.parsed_response['user']['name']
    end

  end # self
end

# p Slack.find_user_name("U0317Q2GS")