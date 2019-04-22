class Expectation < ApplicationRecord
  belongs_to :list
  belongs_to :month

  validates :list, uniqueness: { scope: :month }
end
