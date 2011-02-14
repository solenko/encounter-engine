class LevelBonus < ActiveRecord::Base
  set_table_name :levels_bonuses
  belongs_to :bonus
  belongs_to :level
end