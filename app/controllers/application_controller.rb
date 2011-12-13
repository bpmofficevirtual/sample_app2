class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper ## Cris: Disponibilizar "Functions Session" para Controllers/Views (Obs: Para views "helpers" já ficam disponíveis)
end
