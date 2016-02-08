class UserPolicy < ApplicationPolicy  
  
  def destroy?
    user.admin?
  end 
  
  def new?
    user.nil? || user.admin?
  end
  
  class Scope < Scope
    
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end      
  
  end  

end
