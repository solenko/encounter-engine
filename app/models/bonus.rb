class Bonus < ActiveRecord::Base
  has_many :level_bonuses
  has_many :levels, :through => :level_bonuses
  has_many :answers, :through => :question
  has_one  :question
  belongs_to :game

  validates_presence_of :question,
    :message => "Вы не ввели задание"

  def validate

  end
  
  def price_in_minutes
    self.price.blank? ? nil : self.price.abs / 60
  end
end