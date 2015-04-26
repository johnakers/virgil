module Whois

  # input is name of user
  def self.info(name)
    if self.valid_name?(name)
      this_user = self.user_find(name)
      self.message(this_user)
    else
      "I'm sorry, I do not know that user, or did you mistype something perhaps?"
    end
  end

  def self.valid_name?(name)
    name.empty? || self.user_find(name).empty? ? false : true
  end

  def self.user_find(name)
    found_user = {}
    Slack.users_list.each do |user|
      found_user = user if user['name'] == name
    end
    found_user
  end

  def self.message(user)
    name  = user['name']
    real  = user['real_name']
    loc   = user['tz_label']
    email = user['profile']['email']
    title = user['profile']['title']
    user['is_admin'] ? admin = "are an admin" : admin = "are not an admin"
    user['is_owner'] ? owner = "are an owner" : owner = "are not an owner"
    
    if user['is_bot'] == true
      message = "They are a fellow guide of some sort, though I do not know them well."
    else
      message = "Their real name is #{real}, their email is #{email}. According to my records, they are located in the #{loc} timezone. They hold the title of #{title}, #{admin} and #{owner}."
    end
    message
  end

end