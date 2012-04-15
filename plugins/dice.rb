class Dice
  include Cinch::Plugin

  listen_to :message

  def listen(m)
    if m.message.match /roll/
      m.reply "You rolled", true
    end
  end
end
