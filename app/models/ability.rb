class Ability
  include CanCan::Ability

  def initialize admin
    admin ||= Admin.new
    if admin.is_a?(Admin) && admin.super_admin?
      can :manage, User
    end
    if admin.is_a?(Admin) && admin.admin?
      can :read, User
    end
  end
end
