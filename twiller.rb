require 'cinch'
require_relative 'plugins/auto_op'
require_relative 'plugins/dice'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#twillers']
    c.nick = 'twiller'
    c.plugins.plugins = [AutoOp, Dice]
  end
end

bot.start
