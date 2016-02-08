class UserSessionPolicy < ApplicationPolicy  
  
  def new?
    user.nil?
  end
  
end
