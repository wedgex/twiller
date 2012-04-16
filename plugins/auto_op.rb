class AutoOp
  include Cinch::Plugin

  listen_to :join
  listen_to :message, :method => :add

  def listen(m)
    op_users = bot.config.config['channels'][m.channel]['operators']
    m.channel.op(m.user) if op_users.include?(m.user.nick)
  end

  def add(m)
    rx = /^!op (?<nick>\w+)/
    if (md = rx.match(m.message)) && m.channel.opped?(m.user)
      bot.config.config['channels'][m.channel]['operators'] << md[:nick]
      #TODO save the config
      m.channel.op(md[:nick])
    end
  end
end
