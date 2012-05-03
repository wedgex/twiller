# Loads up Celery Man
# Ported from originan source by github:
# https://github.com/github/hubot-scripts/blob/master/src/scripts/celery-man.coffee


class CeleryMan
  include Cinch::Plugin

  listen_to :message

  # TODO: DRY THIS SHIT UP
  def listen(m)
    m.reply "http://mlkshk.com/r/4SBP.gif" if m.message.match /.*celery\s?man/i

    if m.message.match /.*4d3d3d3/i
      m.reply "4d3d3d3 ENGAGED"
      m.reply "http://i.imgur.com/w1qQO.gif"
    end

    m.reply "http://i.imgur.com/EH2CJ.png" if m.message.match /.*add sequence:? oyster/i
    m.reply "http://i.imgur.com/e71P6.png" if m.message.match /.*oyster smiling/

    if m.message.match /do we have any new sequences/i
      m.reply "I have a BETA sequence I have been working on. Would you like to see it? \n"
    end

    if m.message.match /.*beta sequence/i
      m.reply "http://i.imgur.com/JD6mz.jpg\n"
      m.reply "http://i.imgur.com/TvoxF.gif"
    end

    m.reply "http://i.imgur.com/5kVq4.gif" if m.message.match /.*hat wobble/i
    m.reply "http://i.imgur.com/X0sNq.gif" if m.message.match /.*flarhgunnstow/i
    m.reply "Not computing. Please repeat:" if m.message.match /.*nude tayne/
    m.reply "http://i.imgur.com/yzLcf.png" if m.message.match /NUDE TAYNE/
  end
end