class Artist < ActiveRecord::Base
  has_many :feeds
  has_many :playables
end
