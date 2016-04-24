require 'espn_scraper'


class EspnScraper 
  
  def self.get_score

    basketball = ESPN.get_nba_scores( Date.parse('Apr 23, 2016') )
    hockey = ESPN.get_nhl_scores( Date.parse('Apr 23, 2016') )

    puts "BASKETBALL ON APRIL 19 2016"
    puts basketball

    # puts "HOCKEY ON APRIL 19 2016"
    # puts hockey
 

    basketball.each do |ball|
      home_team = ball[:home_team].upcase
      away_team = ball[:away_team].upcase
      home_score = ball[:home_score] 
      away_score = ball[:away_score] 
      date = ball[:game_date].to_date


      puts home_team
      puts home_score
      puts away_team
      puts away_score
      puts date
      Score.create(home_team: home_team, home_score: home_score, away_team: away_team, away_score: away_score, date:date, sport:'basketball')
    end

  

  end

end