class Spotify
  include Cinch::Plugin
  
  listen_to :message
  def listen(m)
    url_regex = /(?<http>http\:\/\/)?open.spotify.com\/(?<tag>track|album|artist)\/(?<id>[a-zA-Z0-9]{22})/
    match = url_regex.match(m.message)
    if match
      parse(match[:tag],match[:id],m)
    end
  end
  
  def parse(tag,id,m)
    url = "http://ws.spotify.com/lookup/1/?uri=spotify:" + tag + ":" + id
    doc = Nokogiri::XML(open(url))
    if tag == "track"
      track = doc.xpath("//s:track/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      artist = doc.xpath("//s:track/s:artist/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      album = doc.xpath("//s:track/s:album/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      m.reply get_notice(tag) + " #{bold(track)} by #{artist} - #{album}"
    
    elsif tag == "artist"
      artist = doc.xpath("//s:artist/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      m.reply get_notice(tag) + " #{bold(artist)}"
    
    elsif tag == "album"
      album = doc.xpath("//s:album/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      artist = doc.xpath("//s:album/s:artist/s:name/text()",{"s" => "http://www.spotify.com/ns/music/1"})
      year = doc.xpath("//s:album/s:released/text()",{"s" => "http://www.spotify.com/ns/music/1"})
       m.reply get_notice(tag) + " #{bold(album)} - #{year} by #{artist}"
    end
  end
  
  def get_notice(tag)
    Cinch::Formatting.format(:bold,:green, "Spotify #{tag.capitalize}:")
  end
  
  def bold(str)
    Cinch::Formatting.format(:bold, str.to_s)
  end
end