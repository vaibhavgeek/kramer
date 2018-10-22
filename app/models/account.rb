class Account < ApplicationRecord
    
   # belongs_to :owner, class_name: 'User'
   # validates :owner, presence: true
   attr_accessor :firstname, :lastname , :email , :password , :password_confirmation
    restricted = %w(www about projects products stats vaibhav)
    validates :subdomain, presence: true,
                         uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                        exclusion: { in: restricted, message: 'restricted' }
   
    before_validation :downcase_subdomain
    # accepts_nested_attributes_for :owner
    private
    def downcase_subdomain
        self.subdomain = subdomain.try(:downcase)
    end
end
