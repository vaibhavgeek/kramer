class AccountsController < ApplicationController
    layout 'welcome'
    def new
        @account = Account.new
      #  @account.build_owner 
    end
    def create
        @account = Account.new(account_params)
        if @account.save
            Apartment::Tenant.create(@account.subdomain)
            Apartment::Tenant.switch!(@account.subdomain)
            redirect_to subdomain: @account.subdomain, :controller => 'welcome', :action => "index"
        else
            render action: 'new'
        end
    end

    private
    def account_params
        params.require(:account).permit(:subdomain)
    end
end
