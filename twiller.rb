require 'cinch'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require_relative 'config'
require_relative 'plugins/auto_op'
require_relative 'plugins/dice'
require_relative 'plugins/spotify'
require_relative 'plugins/butts'
require_relative 'plugins/youtube'
require_relative 'plugins/diablo'
require_relative 'plugins/interesting'
require_relative 'plugins/markovgen'
require_relative 'lib/markov'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = Twiller::Config['channels'].keys
    c.nick = 'twillbot'
    c.plugins.plugins = [AutoOp, Dice, Spotify, Youtube, Butts, Diablo, Interesting, Markovgen]
  end
end

bot.start
