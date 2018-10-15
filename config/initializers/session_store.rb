# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_zammad_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Rails.application.config.session_store :active_record_store , key: '_zammad_session_' + Digest::MD5.hexdigest(Rails.root.to_s).to_s[5..15] , domain: :all ,  :tld_length => 3   
#Rails.application.config.session_store :cookie_store, key: '_zammad_session_' , domain: :all , 