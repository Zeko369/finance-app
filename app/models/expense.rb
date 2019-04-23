# == Schema Information
#
# Table name: expenses
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  amount     :decimal(, )
#  list_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  month_id   :bigint(8)
#

class Expense < ApplicationRecord
  belongs_to :list
  belongs_to :month
end
