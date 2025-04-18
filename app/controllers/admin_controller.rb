class AdminController < ApplicationController
  http_basic_authenticate_with name: "admin", password: Rails.application.credentials.dig(:admin, :password)
  def show
    @pieces = Piece.all
    @subscribers = Subscriber.all
  end
end
