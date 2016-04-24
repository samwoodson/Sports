require 'twitter'
require 'pry'
require 'active_record'
require 'active_support/all'
# require '../app/models/post.rb'
class PopulateFromTwitter

  def self.get_tweets(twitter_user, sport)
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  "yy8e7CAKbRlYptj73Khb4Np0e"
      config.consumer_secret     = "xuej4OqAMKzc0ESsip9mt7GjYtGzseoYkmDomdYuYoyfLnyL8U"
      config.access_token        = "722875700575768576-0uKpLcj7G779ijNJnBdknzGTF2Kdg1f"
      config.access_token_secret = "zTjhFdH2GzUQKMjPDznmpd7iWCldF8t20ZGxPsS9iJdf1"
    end

    test = client.user_timeline(twitter_user, {count: 100, exclude_replies: true})
    date = Time.now - 172800
    test.each do |tweet|
      unless tweet.retweet?
        if tweet.retweet_count > 150 && tweet.created_at > date
          test=tweet.text
          test = test.gsub(/https:\/\/t.co\/\w{10}/, '')
          embed = client.oembed(tweet, :maxwidth => 375, :omit_script => true).html
          embed = embed.gsub(/<script async.*<\/script>/, '')
          embed = embed.gsub(/\n/, '')
          puts embed
          Post.create(content:test, sport:sport, author:tweet.user.name, url:embed)
        end
      end
    end
  end

end
