namespace :users do
  desc "add role to users"
  task :add_role, [:email] => [:environment] do |t, args|
    user = User.find_by(email: args[:email])
    if user.present?
      user.role = 'admin'
    end
    user.save
  end

  desc "send all users consolidated order mail"
  task send_user_orders_mail: :environment do
    #fixed FIXME: use find_each, batch size, dont use unnecessary variables
    User.joins(:orders).distinct.find_each(batch_size: 2000) do |user|
      OrderMailer.all_user_orders(user).deliver
    end
  end

end
