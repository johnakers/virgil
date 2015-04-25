# files
require_relative 'virgil'
require_relative './modules/module.reference'

# response for determining which type
# of message was input to Virgil
class Interpreter
  class << self

    # examines the messages
    def examine(data)

      # log messages to terminal
      puts "#{data}\n\n"

      # if messages are what we're looking for, interpret and reply
      if data['type'] == 'message' && data['text']
        Interpreter.text(data)
      end

    end

    # how to reply
    def text(data)

      # variables needed
      text = data['text'].downcase.split(' ')
      name = "<@#{Slack.find_user_name(data['user'])}>"
      channel = data['channel']

      # 'virgil [command] [params]'
      if Interpreter.virgil_message?(text)
        # we know first word is 'virgil', grab the rest after 'command' word
        text.shift
        text.first.nil? ? input = nil : input = text[1..-1].join(' ')

        # modules
        case text.first
        when nil
          Virgil.speak(channel, "Yes #{name}?")
        when 'help'
          Virgil.speak(channel, "You need help #{name}? I can help you with:\n\n `echo [words]`, `recite` my works, `forecast [city]` weather, `pathfind` `[to_address, from_address]`, `calculate [math formula]`. Please prefix `vrigil before everything else so I know you're addressing me.`")
        when 'hello'
          Virgil.speak(channel, "Hello #{name}")
        when 'echo'
          Virgil.speak(channel, input)
        when 'recite'
          # TODO (NEED QUOTES)
          Virgil.speak(channel, "Fortune favors the bold... that is all I know, for now #{name}")
        when 'whois'
          # TODO
          Virgil.speak(channel, "I don't know who that is #{name}... yet")
        when 'forecast'
          Virgil.speak(channel, "#{name}, #{Forecast.get(input)}")
        when 'pathfind'
          addresses, locations = Pathfind.determine_input(input), Pathfind.get_locations(addresses)
          Virgil.speak(channel, "#{name}, here is your path: `#{Pathfind.direction_path(locations)}`")
        when 'calculate'
          answer = Calc.ulate(input)
          Virgil.speak(channel, "#{name}, your answer is: *#{answer}*")
        else
          Virgil.speak(channel, "I'm sorry #{name}, I'm afraid I didn't understand `#{text.first}`")
        end # case

      end # if
    end # text

    def virgil_message?(array)
      array.first.eql?('virgil')
    end # virgil_message?

  end # self
end