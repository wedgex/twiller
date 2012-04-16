class Diablo
  include Cinch::Plugin

  listen_to :message
  def listen(m)
    rx = /d(iablo)?[ ]?(3|iii)? out yet/i

    if m.message.match rx
      release = Time.local(2012, 5, 15)
      # Local time had better be right!
      reply = (Time.new >= release) ? 'Yesssssssss' : 'Nope.'
      m.reply reply
    end
  end
end
