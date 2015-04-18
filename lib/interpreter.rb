# files
require_relative 'virgil'
require_relative './modules/reference'

# response for determining which type
# of message was input to Virgil
class Interpreter
  class << self

    def examine(data)

      # log messages
      puts "#{data}"

      if data['type'] == 'message' && data['text']
        Interpreter.text(data)
      end

    end # examine

    def text(data)
      text = data['text'].downcase.split(' ')
      name = "<@#{Slack.find_user_name(data['user'])}>"
      channel = data['channel']

      if Interpreter.virgil_message?(text)
        text.shift

        # none of these should be more than 3 lines
        case text.first
        when nil
          Virgil.speak(channel, "Yes #{name}?")
        when 'help'
          Virgil.speak(channel, "You need help #{name}? I can help you with:\n\n `echo` [words], `recite` my works, `forecast [city]` weather, `pathfind` [to_address, from_address], `calculate [math formula]`. Please prefix `vrigil before everything else so I know you're addressing me.`")
        when 'hello'
          Virgil.speak(channel, "Hello #{name}")
        when 'echo'
          words = text[1..-1].join(' ')
          Virgil.speak(channel, words)
        when 'recite'
          # TODO (NEED QUOTES)
          Virgil.speak(channel, "Fortune favors the bold... that is all I know, for now #{name}")
        when 'whois'
          # TODO
          Virgil.speak(channel, "I don't know who that is #{name}... yet")
        when 'forecast'
          location = text[1..-1].join(' ')
          Virgil.speak(channel, "#{name}, #{Forecast.get(location)}")
        when 'guide'
          # TODO (places near...)
          Virgil.speak(channel, "#{name}, perhaps this will lead to something...")
        when 'pathfind'
          addresses = Pathfind.determine_input(text[1..-1])
          locations = Pathfind.get_locations(addresses)
          Virgil.speak(channel, "#{name}, here is your path: `#{Pathfind.direction_path(locations)}`")
        when 'calculate'
          # TODO
          Virgil.speak(channel, "#{name}, I will know some basic mathematics... soon")
        else
          Virgil.speak(channel, "I'm sorry #{name}, I'm afraid I didn't understand `#{text.first}`")
        end # case

      end # if
    end # text

    def virgil_message?(array)
      array.first.eql?('virgil')
    end

  end # self
end