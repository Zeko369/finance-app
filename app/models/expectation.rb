# == Schema Information
#
# Table name: expectations
#
#  id         :bigint(8)        not null, primary key
#  list_id    :bigint(8)
#  month_id   :bigint(8)
#  amount     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Expectation < ApplicationRecord
  belongs_to :list
  belongs_to :month

  validates :list, uniqueness: { scope: :month }
end
