require 'rake'
class AccountsController < ApplicationController
    layout 'welcome' 
    def new
        @account = Account.new
      #  @account.build_owner 
    end
    def create
        @account = Account.new(account_params)
        firstname,lastname,email,password = account_params[:firstname] , account_params[:lastname] , account_params[:email] , account_params[:password]
        if @account.save
            Apartment::Tenant.create(@account.subdomain)
            Apartment::Tenant.switch!(@account.subdomain)
            ActiveRecord::Base.connection.schema_search_path = Apartment.connection.schema_search_path
	    create_admin_user(firstname,lastname,email,password,@account.subdomain)
            redirect_to subdomain: @account.subdomain, :controller => 'welcome', :action => "index" 
        else
            render action: 'new'
        end
    end
    def create_admin_user(firstname,lastname,email,password,subdomain)
        
        set_all_settings_user(subdomain)

        group_ids = []
        role_ids  = []

        Role.where(name: %w[Admin Agent]).each do |role|
            role_ids.push role.id
        end

        Group.all.each do |group|
            group_ids.push group.id
        end

        user = User.new
        user.updated_by_id = 1
        user.created_by_id = 1
        user.role_ids  = role_ids
        user.group_ids = group_ids
        user.firstname = firstname
        user.lastname = lastname
        user.email = email
        user.password = password
        user.save!

    end

    def set_all_settings_user(sub)
        Setting.set('system_init_done', true)
        Setting.set('es_url', 'http://localhost:9200')
        Calendar.init_setup(request.remote_ip)
        #begin
        #TextModule.load(request.env['HTTP_ACCEPT_LANGUAGE'] || 'en-us')
        #rescue => e
        #    logger.error "Unable to load text modules #{request.env['HTTP_ACCEPT_LANGUAGE'] || 'en-us'}: #{e.message}"
        #end
        models_current = Models.searchable.map(&:to_s)
        models_config = Setting.get('models_searchable')
        setting = Setting.find_by(name: 'models_searchable')
        if setting && models_current != models_config
          Setting.set('models_searchable', models_current)
        end
        Setting.set('fqdn' , sub + ".chaturbots.com")
    end
    private
    def account_params
        params.require(:account).permit(:subdomain , :firstname , :lastname , :email , :password , :password_confirmation)
    end
end
