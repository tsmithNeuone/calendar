ActionMailer::Base.smtp_settings = {
    :address => 'smtp.gmail.com',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true,
    :domain => 'gmail.com',
    :user_name => 'calendarneuone@gmail.com',
    :password => 'neuone2013'
  }