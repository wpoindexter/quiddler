class Letter < ActiveRecord::Base
  validates :text, uniqueness: true
end
