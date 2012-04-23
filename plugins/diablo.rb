class Diablo
  include Cinch::Plugin

  listen_to :message
  def listen(m)
    rx = /d(iablo)?[ ]?(3|iii)? out yet/i

    if m.message.match rx
      release = Time.mktime(2012,5,15,0,0,0,0)
      if Time.now >= release
        m.reply "Oh my god, let\'s play Diablo III!"
      else
        secs = release - Time.now
        time_left = "%d days, %d hours, %d minutes, and %d seconds" % [ secs.to_i / 86400, (secs % 86400).to_i / 3600, *((secs % 3600).divmod(60)) ]
        m.reply "No, you still have #{time_left} left."
      end
    end
  end
end
