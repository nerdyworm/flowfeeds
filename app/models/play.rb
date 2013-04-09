class Play < ActiveRecord::Base
  belongs_to :playable
  belongs_to :user
end
