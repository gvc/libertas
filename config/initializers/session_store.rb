# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_libertas_session',
  :secret      => 'e11fa0907b1dbe91ad3bce2d48ec48063c515afbf0067ab355c5d99b5b68b6e136a8037b986fdf9fcfdc594fd475550efe03292f3ad6183c68e211cd24d7b782'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
