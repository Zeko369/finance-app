class List < ApplicationRecord
  has_many :expenses
  has_many :expectations
end
