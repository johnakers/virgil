module Self

  def self.request_info
    response = HTTParty.get('https://api.github.com/repos/johnakers/virgil/stats/contributors')
    response.parsed_response.first || self.invalid_input
  end

  def self.weeks
    self.request_info['weeks']
  end

  def self.commits
    self.request_info['total']
  end

  def self.additions_deletions
    adds = 0
    dels = 0
    self.weeks.each do |hash|
      adds += hash['a']
      dels += hash['d']
    end
    "#{adds} additions and #{dels} deletions"
  end

  def self.return_info
    if self.commits.nil? || self.weeks.nil? || self.additions_deletions.nil?
      self.invalid_input
    else
      "I am a Slack bot written in the _Ruby_ programming language, named after the Roman poet. I was created by John Akers. To date, I have #{self.commits} commits, with #{self.additions_deletions}. You can find my source code at `https://github.com/johnakers/virgil`"
    end
  end

  def self.invalid_input
    "Something odd occurred, can you please try again in a little bit?"
  end

end