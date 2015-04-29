# gems
require 'faye/websocket'

# files
require_relative 'slack'
require_relative 'interpreter'

class Virgil
  class << self

    # makes a call to Slack.RTM
    # establishes websocket connection
    def exist

      # code from nouvion via @maxdeviant
      EM.run {
        link = Slack.rtm['url']
        socket = Faye::WebSocket::Client.new(link)
        general = Slack.find_general

        socket.on :open do |event|
          Virgil.speak(general, "I'm awake.")
        end

        socket.on :message do |event|
          data = JSON.parse(event.data)
          Virgil.consider(data)
        end

        socket.on :close do |event|
          Virgil.speak(general, "I'm headed back to sleep.")
        end
      }
      
    end # end setup

    # evaluates input
    def consider(data)
      Interpreter.examine(data)
    end

    # output
    def speak(channel, text)
      Slack.message(channel, text)
    end
    
  end # self
end