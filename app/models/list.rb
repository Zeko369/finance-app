# == Schema Information
#
# Table name: lists
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  dirrection  :boolean          default(FALSE)
#  reoccurring :boolean          default(FALSE)
#

class List < ApplicationRecord
  has_many :expenses
  has_many :expectations
end
