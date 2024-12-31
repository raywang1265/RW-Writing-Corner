class Piece < ApplicationRecord
    validates :title, presence: true
    validates :textsource, presence: true
end
