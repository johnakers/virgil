class Help

  def self.info(input)
    # nothing entered... generic response
    if input.empty?
      puts 'herererereereer'
      reply = "my modules are: `self`, `echo`, `recite`, `whois`, `forecast`, `pathfind`, `calculate`. For assistance on a specific module, enter `virgil help [module]`"
    else
      reply = self.module_info(input)
    end

    reply
  end

  # input is a string
  def self.module_info(words)
    words = words.split(' ')

    modules = ['self', 'echo', 'recite', 'whois', 'forecast', 'pathfind', 'calculate']
 
    if modules.include?(words.first)
      self.send(words.first)
    else
      return "apologies, I didn't understand"
    end
  end

  # ---  descriptions of modules ---

  def self.self
    "`self` will give you information about myself. ```Example: *virgil self*```"
  end

  def self.echo
    "`echo` does simply that, echoes words back. ```Example: *virgil echo hello world* would make me say 'hello world'```"
  end

  def self.recite
    "`recite` has me give a quote from one of my works. ```Example: *virgil recite* would make me say a quote```"
  end

  def self.forecast
    "`forecast` has me give the weather forecast for a city. ```Example: *virgil forecast san francisco* would make me say 'the weather is [whatever the current and future weather may be]'```"
  end

  def self.pathfind
    "`pathfind` has me give you a link to directions of your path. ```Example: *virgil pathfind to 760 Market Street, San Francisco, CA from 633 Folsom Street, San Francisco, CA* would return a link to a map with directions```"
  end

  def self.calculate
    "`calculate` has me derive a mathematial solution to the formula you provided. ```Example: *virgil calculate 9 * 3* would return 27```"
  end

end