class AddedScore < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.integer :score, default: 0
    end
  end
end