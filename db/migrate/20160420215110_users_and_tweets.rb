class UsersAndTweets < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_hash
      t.timestamps 
    end

    create_table :posts do |t|
      t.text :content
      t.string :sport
      t.string :author
      t.string :url
      t.belongs_to :user
      t.timestamps
    end

    create_table :reports do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps   
    end

    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps
    end

  end
end
