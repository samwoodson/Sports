require 'twitter'
require 'pry'
require 'active_record'
require 'active_support/all'
# require '../app/models/post.rb'
class PopulateFromTwitter

  def self.get_tweets(twitter_user, sport)
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = test
      config.consumer_secret     = test
      config.access_token        = test
      config.access_token_secret = test
    end

    test = client.user_timeline(twitter_user, {count: 150, exclude_replies: true})
    date = Time.now - 172800
    test.each do |tweet|
      unless tweet.retweet?
        if tweet.retweet_count > 150 && tweet.created_at > date
          test=tweet.text
          test = test.gsub(/https:\/\/t.co\/\w{10}/, '')
          embed = client.oembed(tweet, :maxwidth => 375, :omit_script => true).html
          embed = embed.gsub(/\n/, '')
          Post.create(content:test, sport:sport, author:tweet.user.name, url:embed)
        end
      end
    end
  end

end
