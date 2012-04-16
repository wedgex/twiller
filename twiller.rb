require 'cinch'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require_relative 'plugins/auto_op'
require_relative 'plugins/dice'
require_relative 'plugins/spotify'
require_relative 'plugins/butts'
require_relative 'plugins/youtube'
require_relative 'plugins/diablo'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.config = YAML.load(File.open('config.yaml'))
    c.channels = c.config['channels'].keys
    c.nick = 'twillbot'
    c.plugins.plugins = [AutoOp, Dice, Spotify, Youtube, Butts, Diablo]
  end
end

bot.start
