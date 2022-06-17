# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, :all
      return
    end
    
    can :read, :all
    return unless user.present?

    can :manage, :all, user_id: user.id
    return unless user.role == 'admin'

    can :manage, :all
  end
end
