class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != %w( www )
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank? || request.subdomain == %w( www )
  end
end

Rails.application.routes.draw do
  
  constraints(SubdomainBlank) do
    resources :accounts, only: [:new, :create]
    root 'welcome#index'
    get 'welcome/pricing'
    get 'welcome/feature'
    get 'welcome/features'
    get 'welcome/about_us'
  end
 

  constraints(SubdomainPresent) do
    
    # app init
    match '/init', to: 'init#index', via: :get
    match '/app',  to: 'init#index', via: :get

    # just remember to delete public/index.html.
    root to: 'init#index', via: :get

    # load routes from external files
    dir = File.expand_path(__dir__)
    files = Dir.glob( "#{dir}/routes/*.rb" )
    files.each do |file|
      if Rails.configuration.cache_classes
        require file
      else
        load file
      end
    end
  
  end  
#  match '*a', to: 'errors#routing', via: %i[get post put delete]

end
