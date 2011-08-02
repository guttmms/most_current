class RegistrationsController < SessionsController
  private
  
  def create
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
    
end
