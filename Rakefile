require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)
require './lib/populate_from_twitter.rb'
require './lib/populate_from_reddit.rb'

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Populates the DB'
task "db:populate" do
  #PopulateFromTwitter.get_tweets("nba", "basketball")
  #PopulateFromTwitter.get_tweets("WojVerticalNBA", "basketball")
  #PopulateFromTwitter.get_tweets("nhl", "hockey)
  #PopulateFromTwitter.get_tweets("nhl", "hockey")
  #PopulateFromTwitter.get_tweets("tsnhockey", "hockey")
  #PopulateFromReddit.get_posts("hockey", "hockey")
  #PopulateFromReddit.get_posts("nba", "basketball")
  
  #PopulateFromTwitter.get_tweets("DarrenDreger", "hockey")
end