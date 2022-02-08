class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?

    if user.admin?
      can :manage, :all
    else
      can %i(show create update), Order, user_id: user.id
    end
  end
end
