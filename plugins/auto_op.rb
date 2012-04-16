class AutoOp
  include Cinch::Plugin

  listen_to :join
  listen_to :message, :method => :add

  def listen(m)
    op_users = Twiller::Config['channels'][m.channel]['operators']
    m.channel.op(m.user) if op_users.include?(m.user.nick)
  end

  def add(m)
    rx = /^!op (?<nick>\w+)/
    if (md = rx.match(m.message)) && m.channel.opped?(m.user)
      Twiller::Config['channels'][m.channel]['operators'] << md[:nick]
      Twiller::Config.save

      m.channel.op(md[:nick])

      m.reply "[AUTO-OP] #{md[:nick]} added to the ops list for #{m.channel}."
    end
  end
end
