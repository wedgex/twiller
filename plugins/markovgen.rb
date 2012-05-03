class Markovgen
  include Cinch::Plugin
  
  listen_to :message
  
  def initialize(*args)
    super
    @markovbot = Markov.new
    @markovbot.load
    @markov_switch = true
    @markov_freq = 10
    @markov_msg_counter = 0
    @markov_earmuffs = false
  end
  
  def listen(m)
    @markov_msg_counter += 1
    reject = /(http[s?]|www.\w*|\w*.com|\w*.net|\w*.biz)/
    switch_regex = /!markov\s(?<switch>on|off|earmuffs)/
    freq_regex = /!markov\s(?<freq>\d+\z)/
    match = switch_regex.match(m.message)
    fmatch = freq_regex.match(m.message)
    if match
      if match[:switch] == "on" && m.channel.opped?(m.user)
        @markov_switch = true
        m.reply "[MARKOV] turned on."
      elsif match[:switch] == "off" && m.channel.opped?(m.user)
        @markov_switch = false 
        m.reply "[MARKOV] turned off."
      elsif match[:switch] == "earmuffs" && m.channel.opped?(m.user)
        @markov_earmuffs = !@markov_earmuffs
        m.reply "[MARKOV] message listening OFF" if @markov_earmuffs
        m.reply "[MARKOV] message listening ON" if !@markov_earmuffs
      end
    elsif fmatch
      @markov_freq = fmatch[:freq].to_i
      @markov_freq = 100 if fmatch[:freq].to_i > 100
      @markov_freq = 0 if fmatch[:freq].to_i < 0
      m.reply "[MARKOV] Frequency set to #{@markov_freq}%"
    elsif m.message.match(/![\w]+ (on|off)/) # catch other commands
    elsif m.user != "twillbot"
      text = m.message
      mtext = text.gsub(reject, '')
      @markovbot.add(mtext)
    end
    
    if @markov_switch && rand(100) < @markov_freq
      m.reply @markovbot.get_chain 
    end
    
    if @markov_msg_counter > 100
      @markovbot.save
      @markov_msg_counter = 0
    end
  end
end