require 'cinch'
require 'open-uri'
require 'nokogiri'
require_relative 'plugins/auto_op'
require_relative 'plugins/dice'
require_relative 'plugins/youtube'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#twillers']
    c.nick = 'twiller'
    c.plugins.plugins = [AutoOp, Dice, Youtube]
  end
end

bot.start
