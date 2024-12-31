class Subscriber < ApplicationRecord
    generates_token_for :unsubscribe
end
