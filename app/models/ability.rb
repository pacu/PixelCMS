class Ability
  include CanCan::Ability


  def initialize(user)
    @user = user
    can :read, ActiveAdmin::Page, :name => 'Dashboard'
    can :read, ActiveAdmin::Page, :name => 'Login'
    @user.roles.each { |role| send(role.class.to_s.underscore, role) }

    if @user.roles.size == 0
      can :read, :all #for guest without roles
    end
  end

  #Story: As a Publication admin I would like to be able to update my publication's issues
  def publication_admin(role)
    can :read, Publication, :id => role.publication_id
    can :update, Publication, :id => role.publication_id
    can :manage, Issue, :publication_id => role.publication_id
    can :update, AdminUser, :id => @user.id

  end

  #Story: As a Publisher Admin I would like to edit my publications and their states
  def publisher_admin(role)

    can :manage, Publication, :publisher_id => role.publisher_id
    can :update, Publisher, :id => role.publisher_id
    can :update, IssueState
    can :update, AdminUser, :id => @user.id



  end

  #Story: As a Pixel Admin I would like to manage publishers, their publications, their issues and their contents

  def pixel_admin(role)
    can :manage, Issue
    can :manage, Content
    can :manage, Section
    can :manage, Publisher
    can :manage, Publication
    can :manage, Proceeding
    can :manage, Sale
    can :update, AdminUser, :id => @user.id

  end

  def super_admin(role)

    can :manage, :all

  end
end
