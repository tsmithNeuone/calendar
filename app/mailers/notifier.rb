class Notifier < ActionMailer::Base
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.gmail_message.subject
  #
 def gmail_message(user)
 
    mail(:to => user, :subject => "Event Reminder", :from => "calendarneuone@gmail.com")
   
  
  end
end
