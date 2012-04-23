class Interesting
  include Cinch::Plugin

  listen_to :message
  def listen(m)
  
    if m.message.length > 50 && m.user == "syntaxrigger"
      m.reply "Interesting." if rand(100) < 20
    end
  end
end
