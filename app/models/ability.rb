class Ability
  include CanCan::Ability
  def initialize(user)
    if user.is_admin?
      can :manage, :all
    else
      can :read, [Problem, Solution], :visible => true
      can :manage, [Problem, Solution], :user_id => user.id
    end
  end
end