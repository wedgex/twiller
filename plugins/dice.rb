class Dice
  include Cinch::Plugin

  match /roll/, :method => :roll

  def roll(m)
    m.reply "You rolled", true
  end
end
