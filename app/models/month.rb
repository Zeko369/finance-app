# == Schema Information
#
# Table name: months
#
#  id         :bigint(8)        not null, primary key
#  month      :integer          not null
#  year       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Month < ApplicationRecord
  has_many :expectations, dependent: :destroy
  has_many :expenses, dependent: :nullify

  after_create :add_expectations

  validates :month, uniqueness: { scope: :year }

  def name
    "#{month+1} - #{year}"
  end

  def add_expectations
    return unless Month.count > 1
    new_expectations = Month.order(id: :desc).offset(1).first.expectations.map do |exp|
      Expectation.create!(list_id: exp.list_id, amount: exp.amount, month: self)
      # if exp.list.reoccurring
      #   exp.list.expenses.each do ||
      # end
    end
    self.update(expectations: new_expectations)
  end

  def self.current
    curr_date = Time.zone.now
    self.find_or_create_by(month: curr_date.month - 1, year: curr_date.year)
  end
end
