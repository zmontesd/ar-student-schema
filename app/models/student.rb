require_relative '../../db/config'

class Student < ActiveRecord::Base

  validates :email, presence: true, format: {with: /\w+@\w+\.\w{2,}/},
                    uniqueness: {case_sensitive: false}
  validates :age, presence: true, :numericality => {:greater_than => 5}
  validates :phone_digits, :length => { :minimum => 10 }

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

  def phone_digits
    phone.gsub(/[^0-9]/,"")
  end
end