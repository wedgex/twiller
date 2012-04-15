class Dice
  include Cinch::Plugin

  listen_to :message
  def listen(m)
    dice_regex = /!roll\s(?<d1>\d+)d(?<d2>\d+)(\z|\+(?<d3>\d+))?/
    match = dice_regex.match(m.message)
    if match
      m.reply "You rolled #{roll(match[:d1],match[:d2],match[:d3])}", true
    end
  end
  
  def roll(d1,d2,d3)
    result = d1.to_i * (1 + rand(d2.to_i))
    result = result + d3.to_i if (d3.to_i)
  end
end
