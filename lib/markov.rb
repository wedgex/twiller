class Markov
  
  def initialize
    @firsts = []
    @data = {}
  end
  
  def add(statement)
    words = statement.split
    if words.length > 2
      @firsts << words[0] + " " + words[1]
      for x in 0..(words.length - 2)
        piece = words[x] + " " + words[x+1]
        if @data.has_key?(piece)
          if words[x+2] != nil
            @data[piece] << words[x+2] 
          else
            @data[piece] << "!!!END!!!"
          end
        else
          if words[x+2] != nil
            @data[piece] = [words[x+2]] 
          else
            @data[piece] = ["!!!END!!!"]
          end
        end
      end
    end
  end
  
  def get_chain
    fragment = @firsts[rand(@firsts.length - 1)]
    statement = fragment
    while (nextlist = @data[fragment]) != nil
      nextword = nextlist[rand(nextlist.length - 1)]
      if nextword == "!!!END!!!"
        break
      elsif statement.split.length > 20
        break
      else
        statement = statement + " " + nextword
        fragment = fragment.split[1] + " " + nextword
      end
    end
    statement
  end
end