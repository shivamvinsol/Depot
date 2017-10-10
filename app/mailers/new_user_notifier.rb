class NewUserNotifier < ApplicationMailer

  default from: 'shivam jain <depot.app.mail@gmail.com>'

  def welcome(user)
    mail to: user.email, subject: 'Welcome Abroad', body: "Hi, #{user.name}, welcome to depot app :)"
  end
end
