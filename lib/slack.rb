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
      HTTParty.post("https://slack.com/api/auth.test?token=#{self.token}")
    end

    def message(channel, text)
      HTTParty.post("https://slack.com/api/chat.postMessage?token=#{self.token}&channel=#{channel}&text=#{text}&username=virgil&as_user=true")
    end

    def channel_list
      HTTParty.post("https://slack.com/api/channels.list?token=#{self.token}")
    end

    def find_general
      response = self.channel_list
      parsed = response.parsed_response
      channels = parsed['channels']
      general = ''
      channels.each { |chan| general = chan['id'] if chan['is_general'] }
      general
    end

    def rtm
      HTTParty.post("https://slack.com/api/rtm.start?token=#{self.token}") 
    end

    def find_user_name(id)
      resp = HTTParty.post("https://slack.com/api/users.info?token=#{self.token}&user=#{id}")
      return 'Philistine' if resp.nil?
      resp.parsed_response['user']['name']
    end

    def users_list
      resp = HTTParty.post("https://slack.com/api/users.list?token=#{self.token}")
      resp.parsed_response['members']
    end

  end # self
end