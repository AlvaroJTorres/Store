# frozen_string_literal: true

# General configuration for the policies generated by the Pundit gem
class ApplicationPolicy
  # user reffers of the current user
  # record is the model object to be check by the authorization
  attr_reader :user, :record

  # Initialize the user and record to be revised
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Define default policy for index controllers
  def index?
    false
  end

  # Define default policy for show controllers
  def show?
    false
  end

  # Define default policy for create controllers
  def create?
    false
  end

  # Define default policy for new controllers
  def new?
    create?
  end

  # Define default policy for update controllers
  def update?
    false
  end

  # Define default policy for edit controllers
  def edit?
    update?
  end

  # Define default policy for destroy controllers
  def destroy?
    false
  end

  # Scopes
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
