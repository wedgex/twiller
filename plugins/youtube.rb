class Youtube
  include Cinch::Plugin
  
  listen_to :message

  def listen(m)
    rx = /www\.youtube\.com\/watch\?.*v=(?<id>[A-Za-z0-9_-]+)/

    if md = m.message.match(rx)
      url = "http://gdata.youtube.com/feeds/api/videos/#{md[:id]}?v=2"
      doc = Nokogiri::XML(open(url))
      title = doc.xpath('//media:title/text()', {'media' => 'http://search.yahoo.com/mrss/' })

      m.reply Cinch::Formatting.format("%s: #{title}" % [Format(:bold, :red, 'YouTube')])
    end
  end
end
