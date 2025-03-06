class SubscribersController < ApplicationController
  
    def create
      # Attempt to find or create a subscriber based on email
      Subscriber.where(subscriber_params).first_or_create
      flash[:notice] = "Subscribed!"
      redirect_to root_path  # or wherever you want to redirect
    end
  
    private
  
    def subscriber_params
      # Permit only the `email` parameter
      params.require(:subscriber).permit(:email)
    end
  end
