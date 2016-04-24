class AddScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :away_team
      t.string :home_team
      t.integer :away_score
      t.integer :home_score
      t.date :date
      t.string :sport
      t.timestamps
    end
  end
end