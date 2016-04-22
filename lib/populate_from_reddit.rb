require 'redditkit'
require 'pry'

class PopulateFromReddit

  def self.get_posts(subreddit, sport)
    test= RedditKit.links subreddit, :category=> :top, :time => :week
    test.results.each do |link| 
      comments = RedditKit.comments(link)
      comment = comments[0] 
      unless comment.text.match(/locking this thread/) || comment.text.match(/fuck/)
        title = link.title
        content = comment.text
        Post.create(title: title, content:content, sport:sport, author:comment.author)
      end
    end
  end


end
