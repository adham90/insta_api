class State < ActiveRecord::Base
  belongs_to :bug

  validates_numericality_of :memory, :storage
end
