Rails.application.config.before_initialize do
  REGEXP = {
    permalink: /\A(([a-z0-9])+-){2,}([a-z0-9])+\Z/i,
    email: /\A[0-9a-z_\.]{2,20}@[0-9a-z]{2,20}(\.[a-z]{2,3}){1,2}\Z/i
  }

  if Rails.env == "development"
    MAIL = {
      from: 'depot dev <depot.app.mail@gmail.com>'
    }
  elsif Rails.env == "production"
    MAIL = {
      from: 'depot prod<depot.app.mail@gmail.com>'
    }
  else
    MAIL = {
      from: 'depot test<depot.app.mail@gmail.com>'
    }
  end
end
