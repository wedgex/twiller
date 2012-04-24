class Markovgen
  include Cinch::Plugin
  
  listen_to :message
  
  def initialize(*args)
    super
    @markovbot = Markov.new
    @markov_switch = false
  end
  
  def listen(m)
  
    reject = /http[s?]|www|.com|.net|.biz|/
    switch_regex = /!markov\s(?<switch>on|off)/
    match = switch_regex.match(m.message)
    if match
      if match[:switch] == "on" && m.channel.opped?(m.user)
        @markov_switch = true
        m.reply "[MARKOV] turned on."
      elsif match[:switch] == "off" && m.channel.opped?(m.user)
        @markov_switch = false 
        m.reply "[MARKOV] turned off."
      end
    elsif m.message.match(/![\w]+ (on|off)/) # catch other commands
    elsif m.user != "twillbot"
      text = m.message
      words = text.split
      final_words = words
      words.each do |word|
        final_words.delete(word) if word.match(reject)
      end
      @markovbot.add(*final_words)
    end
    
    if @markov_switch && rand(100) < 3
      message = @markovbot.generate(10).join(" ") + "."
      m.reply message
    end
  end
end