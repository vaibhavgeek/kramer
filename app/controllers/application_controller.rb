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

  before_action :load_schema 

  private 
  def load_schema
      Apartment::Tenant.switch!('public')
      return unless request.subdomain.present?
      
      account = Account.where(subdomain: request.subdomain).first
      if account
         Apartment::Tenant.switch!(account.subdomain)
         ActiveRecord::Base.connection.schema_search_path = Apartment.connection.schema_search_path
      else
        redirect_to subdomain: false, :controller => 'welcome', :action => "index"
      end
    
  end

  
  
 
end
