class AccountsController < ApplicationController
    layout 'welcome'
    def new
        @account = Account.new
        @account.build_owner 
    end
    def create
        @account = Account.new(account_params)
        if @account.save
            Apartment::Tenant.create(@account.subdomain)
            Apartment::Tenant.switch(@account.subdomain)
            redirect_to root_path(subdomain: @account.subdomain)
        else
            render action: 'new'
        end
    end

    private
    def account_params
        params.require(:account).permit(:subdomain, owner_attributes: [:firstname , :lastname, :email , :password ])
    end
end
