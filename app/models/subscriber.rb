class Subscriber < ApplicationRecord
    generates_token_for :unsubscribe
    after_create :send_welcome_email

    def send_welcome_email
        PieceMailer.with(subscriber: self).welcome_email.deliver_later
    end
end
