class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    puts "user email: #{@user.email}"
    @url = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Welcome to The Knowledge Graveyard")
  end
end
