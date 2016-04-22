class Post < ActiveRecord::Base
    belongs_to :user
    has_many :reports
    has_many :votes

end