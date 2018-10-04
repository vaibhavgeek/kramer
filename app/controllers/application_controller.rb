# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
class ApplicationController < ActionController::Base
  include ApplicationController::HandlesErrors
  include ApplicationController::HandlesDevices
  include ApplicationController::HandlesTransitions
  include ApplicationController::Authenticates
  include ApplicationController::SetsHeaders
  include ApplicationController::ChecksMaintainance
  include ApplicationController::RendersModels
  include ApplicationController::HasUser
  include ApplicationController::HasResponseExtentions
  include ApplicationController::PreventsCsrf
  include ApplicationController::LogsHttpAccess
  include ApplicationController::ChecksAccess

 # protect_from_forgery with: :exception

  before_action :load_schema 

  private 
  def load_schema
      Apartment::Tenant.switch!('public')
      return unless request.subdomain.present?

      account = Account.find_by(subdomain: request.subdomain)
       if account
         Apartment::Tenant.switch!(account.subdomain)
      else
         redirect_to root_url(subdomain: false)
      end
    
  end
  
  
 
end
