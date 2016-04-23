class AddTitle < ActiveRecord::Migration
    def change
    change_table :posts do |t|
      t.string :title
    end
  end
end