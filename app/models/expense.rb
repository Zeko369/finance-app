class Expense < ApplicationRecord
  belongs_to :list
  belongs_to :month
end
