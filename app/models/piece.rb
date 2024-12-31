class Piece < ApplicationRecord
    validates :title, presence: true
    validates :textsource, presence: true

    after_create :notify_subscribers

    def notify_subscribers
        Subscriber.all.each do |subscriber|
          PieceMailer.with(piece: self, subscriber: subscriber).new_piece.deliver_later
        end
    end
end
