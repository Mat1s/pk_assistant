# ActionDispatch::Cookies::CookieOverflow
# https://stackoverflow.com/questions/17344983/cookie-overflow-with-twitter-sign-in
#  twitter upload much params and cokies is fell
# session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
# not help
# https://stackoverflow.com/questions/9473808/cookie-overflow-in-rails-application
# 
# decide how to set locale
# https://stackoverflow.com/questions/8390394/switch-language-with-a-url-in-ruby-on-rails-3
# 
# "fe_sendauth: no password supplied"
# https://github.com/capistrano/rails/issues/80
# 
# 
# mailcatcher broken
# must install through gem install mailcatcher
# https://github.com/sj26/mailcatcher
# config.action_mailer.default_url_options = { host: 'localhost:3000' }
# config.action_mailer.perform_caching = false
# config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = { :address => '127.0.0.1', :port => 1025 }
# config.action_mailer.raise_delivery_errors = false
# config.action_mailer.perform_deliveries = true
# 
