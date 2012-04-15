require 'cinch'
require 'nokogiri'
require 'open-uri'
require_relative 'plugins/auto_op'
require_relative 'plugins/dice'
require_relative 'plugins/spotify'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#twillers']
    c.nick = 'twillbot'
    c.plugins.plugins = [AutoOp, Dice, Spotify]
  end
end

bot.start
