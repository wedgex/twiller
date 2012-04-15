class AutoOp
  include Cinch::Plugin

  listen_to :join

  def listen(m)
    # TODO maintain this list somewhere else, and seperate by channel.
    op_users = ['wedgex', 'vaxinate', 'poemdexter']
    m.channel.op(m.user) if op_users.include?(m.user.nick)
  end
end
