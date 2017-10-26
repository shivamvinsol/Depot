namespace :users do
  desc "add role to users"
  task :add_role, [:email] => [:environment] do |t, args|
    @user = User.find_by(email: args[:email])
    if @user.present?
      @user.role = 'admin'
    end
    @user.save
  end

  desc "send all users consolidated order mail"
  task send_user_orders_mail: :environment do
    @users = User.joins(:orders).distinct # users with atleast one order
    @users.each do |user|
      ConsolidatedOrderMailer.all_user_orders(user).deliver
    end
  end

end
