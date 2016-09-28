class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user, :search]

  def show
    render template: "pages/#{params[:page]}"
  end

  def create
    render template: "pages/search"
  end
end
