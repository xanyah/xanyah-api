# frozen_string_literal: true

module DoorkeeperUserConcern
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(id: cached_doorkeeper_token.resource_owner_id) unless cached_doorkeeper_token&.revoked?
  end

  def cached_doorkeeper_token
    @cached_doorkeeper_token ||= doorkeeper_token
  end

  def authenticate_user!
    raise Pundit::NotAuthorizedError if current_user.nil?
  end
end
