class Team < ApplicationRecord

  attr_accessor :comp_teams_attributes, :members_attributes
  validates :name, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  # accepts_nested_attributes_for :members, reject_if: proc { |attributes| attributes[:user_id].blank? }, allow_destroy: true

  has_many :comp_teams, dependent: :destroy
  has_many :competitions, through: :comp_teams
  accepts_nested_attributes_for :comp_teams, allow_destroy: true, reject_if: proc { |attributes| attributes[:competition_id].blank? }

  has_many :team_skills, dependent: :destroy
  has_many :skills, through: :team_skills

  has_many :invites, dependent: :destroy

  has_many :notifications, foreign_key: :notifiable_id

  # scope :complementary,

  def self.mine(user)
    user.admin ? where(:lead_id=>user):where(:id=>Member.where(user:user).select(:team_id))
  end

  def skill_set

    data = []
    Skill.group(:category).count.each do |cat|
      set = {}
      set[:name] = cat[0]
      set[:data] = []
      self.team_skills.where(skill:Skill.where(category:cat)).each do |skill|
        set[:data] << [skill.name,skill.level]
      end
      data << set
    end
    data
  end

  def skill_group
    data = Skill.group(:category).order(:category).count
    data.each {|k,v|data[k]=0}
    skills = self.team_skills
    skills.each do |s|
      data[s.skill.category] += s.weighted_level.round(1)
    end
    data
  end

  def is_lead(user)
    user.id == lead_id
  end

  def lead
    User.where(:id=>lead_id)
  end

  def is_member(user)
    self.members.where(user:user).present?
  end

  def skill_update #TODO check if team skills change when Members edit skills / leaves team
    self.team_skills.update_all(level:0)#,count:0)
    users = self.users
    users.find_each do |user|
      user.user_skills.each do |us|
        if self.team_skills.where(skill:us.skill).present?
          l = self.team_skills.where(skill:us.skill).first.level || 0
          # c = self.team_skills.where(skill:us.skill).first.count || 0
          level = [l,us.level].max
          # count = c+1
          self.team_skills.where(skill:us.skill).first.update_attributes(level:level)#,count:count)
        else
          self.team_skills.create(level:us.level,skill:us.skill)#,count:1)
        end
      end
    end
  end

  # def skill_add(user)
  #   user.user_skills.each do |us|
  #     if self.team_skills.where(skill:us.skill).present?
  #       l = self.team_skills.where(skill:us.skill).first.level
  #       c = self.team_skills.where(skill:us.skill).first.count
  #       level = [l,us.level].max
  #       count = c+1
  #       self.team_skills.where(skill:us.skill).first.update_attributes(level:level,count:count)
  #     else
  #       self.team_skills.create(level:us.level,skill:us.skill,count:1)
  #     end
  #   end
  # end

  # def skill_delete(user)
  #   user.user_skills.each do |us|
  #     m = self.members.where(user_id:UserSkill.where(skill:us.skill).select(:user_id))
  #     l = m.collect{|m|m.user.user_skills.where(skill:us.skill).first.level} - [us.level]
  #     c = self.team_skills.where(skill:us.skill).first.count - 1
  #     c==0 ? self.team_skills.where(skill:us.skill).first.destroy : self.team_skills.where(skill:us.skill).first.update_attributes(level:[l].max.max,count:c)
  #   end
  # end

  # def self.skill_match(user)
  #   skills = user.skills
  #   nteams = Team.where.not(id:TeamSkill.where(skill:skills).select(:team_id))
  #   yteams = Team.where(id:TeamSkill.where(skill:skills).select(:team_id))
  #   nteams.order('team_skil  ls_count ASC') | yteams.order('team_s   kills_count ASC')
  # end

end