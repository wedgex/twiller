class Butts
  include Cinch::Plugin
  
  listen_to :message
  @buttbot_switch = false
  
  def listen(m)
    switch_regex = /!buttbot\s(?<switch>on|off)/
    match = switch_regex.match(m.message)
    if match
      if match[:switch] == "on" && m.channel.opped?(m.user)
        @buttbot_switch = true
        m.reply "[BUTTBOT] turned on."
      elsif match[:switch] == "off" && m.channel.opped?(m.user)
        @buttbot_switch = false 
        m.reply "[BUTTBOT] turned off."
      end
    elsif @buttbot_switch
      if rand(100) < 3
        words = m.message.split
        replace_word = words[rand(words.count)]
        newmsg = m.message
        newmsg[replace_word] = "butt"
        m.reply "[BUTTBOT] " + newmsg
      end
    end
  end
end