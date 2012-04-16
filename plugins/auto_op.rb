class AutoOp
  include Cinch::Plugin

  listen_to :join
  listen_to :message, :method => :add

  def listen(m)
    op_users = Twiller::Config['channels'][m.channel]['operators']
    m.channel.op(m.user) if op_users.include?(m.user.nick)
  end

  # responds to:
  # !op command nick
  # and
  # !op nick
  # if command is either add or remove it adds or removes the nick
  # from the operators lists. If the command was add it also gives
  # operator status to the user right away.
  #
  # If there was no command given it just gives operator status to 
  # the user with the given nick.
  def add(m)
    rx = /^!op (?<command>\w+ )?(?<nick>\w+)/i
    if (md = rx.match(m.message)) && m.channel.opped?(m.user)
      if command = md[:command]
        case command
        when /add/i
          Twiller::Config['channels'][m.channel]['operators'] << md[:nick]
          Twiller::Config.save
          m.channel.op(md[:nick])
          m.reply "[AUTO-OP] #{md[:nick]} added to the ops list for #{m.channel}."
        when /remove/i
          Twiller::Config['channels'][m.channel]['operators'].delete(md[:nick])
          Twiller::Config.save
        end
      else
          m.channel.op(md[:nick])
      end
    end
  end
end
