class SmangIt
  include Cinch::Plugin
  
  listen_to :message
  
  def listen(m)
    switch_regex = /!smangit/
    match = switch_regex.match(m.message)
    if match
        m.reply sm_l + sm_link + sm_r
    end
  end
  
  def sm_link
    Cinch::Formatting.format(:bold,:green, "http://bit.ly/JfYOPa")
  end
  
  def sm_l
    Cinch::Formatting.format(:bold,:red, "--> ")
  end
  
  def sm_r
    Cinch::Formatting.format(:bold,:red, " <--")
  end
end