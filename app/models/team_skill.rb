class TeamSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :team#, counter_cache: true

  # after_initialize :init
  #
  # def init
  #   self.count ||= 0
  # end

  def name
    self.skill.name
  end
  # TODO rethink the scoring mechanism
  def weighted_level

    (self.level*self.skill.rank)*1.00 #need to find optimized way to evaluate multiplier
  end

end
