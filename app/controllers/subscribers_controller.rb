class SubscribersController < ApplicationController
  
    def create
      # Attempt to find or create a subscriber based on email
      Subscriber.where(subscriber_params).first_or_create
      redirect_to root_path, notice: "Subscribed!"
    end
  
    private
  
    def subscriber_params
      # Permit only the `email` parameter
      params.require(:subscriber).permit(:email)
    end
  end
  