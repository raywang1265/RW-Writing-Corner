# Preview all emails at http://localhost:3000/rails/mailers/piece_mailer
class PieceMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/piece_mailer/new_piece
  def new_piece
    PieceMailer.new_piece
  end
end
