module SessionsHelper
 
   def sign_in(user)
     cookies.permanent.signed[:remember_token] = [user.id, user.salt]
     self.current_user = user
   end

   def current_user=(user)
      @current_user = user
   end

   def current_user
      @current_user ||= user_from_remember_token ## inicializa somente se @current_user for "nil"
   end

   def user_from_remember_token
      User.authenticate_with_salt(*remember_token) ## "*" transforma os elementos do array em argumentos ( retorna [id, sal] )
   end

   def remember_token
      cookies.signed[:remember_token] || [nil,nil]  ## [user.id, user.salt]
   end

   def signed_in?
      !current_user.nil?
   end

   def sign_out
      cookies.delete(:remember_token)
      self.current_user = nil
   end

end
