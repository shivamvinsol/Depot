class WelcomeUser < ApplicationMailer

  # layout "mailer.html.erb"

  #fixed FIXME: move this email to constant.rb Also make this setting env. based.
  #fixed FIXME: What all different rails env by default. And what are the differences
  default from: MAIL[:from]

  def welcome(user)
    @user = user
    #fixed FIXME: don't specify body here. use mail template. Make one email layout.
    mail to: @user.email, subject: 'Welcome Aboard'
    #, body: "Hi, #{user.name}, welcome to depot app :)"
  end
end
