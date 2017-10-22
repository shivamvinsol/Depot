namespace :users do
  desc "add role to users"
  task :add_role, [:email] => [:environment] do |t, args|
    @user = User.find_by(email: args[:email])
    if @user.present?
      @user.role = 'admin'
    end
    @user.save
  end
end
