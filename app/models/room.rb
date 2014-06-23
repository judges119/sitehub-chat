class Room < ActiveRecord::Base
  has_many :entries, :dependent => :destroy
  has_many :users
end
