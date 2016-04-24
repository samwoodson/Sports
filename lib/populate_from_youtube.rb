require 'yt'


class PopulateFromYoutube
  
  def self.get_youtube(id, sport)
    
    Yt.configure do |config|
      config.api_key = your_key
    end
    begin
      date = Time.now - 2592000
      playlist = Yt::Playlist.new id: id
      items = playlist.playlist_items
      items.each do |item|
        video = item.video
        # puts video.published_at.to_time
        # puts date
        if video.published_at.to_time > date
          title = video.title
          embed = video.embed_html
          embed = embed.gsub('width="640" height="360"', 'width="290" height="170"')
          Post.create(content:title, sport:sport, author:'youtube', url:embed)
        end
         
      end
    rescue Exception => e
        puts "broke"

    end
  end
end

# PopulateFromYoutube.get_youtube('PLlVlyGVtvuVkO2UhE8VWy0YRaBNXMXJ5P', 'basketball')