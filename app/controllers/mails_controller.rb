class MailsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize! :manage, :song

    @users = User.all
    @users.select do |user|
        UserMailer.mail_all(user, params[:subject], params[:message]).deliver_now
    end

    redirect_to pages_user_path, notice: 'Message was sent'
  end
end
