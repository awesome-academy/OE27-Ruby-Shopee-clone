class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
    else
      can %i(read create), Product
      can %i(update destroy), Product, user_id: user.id
    end
  end
end
