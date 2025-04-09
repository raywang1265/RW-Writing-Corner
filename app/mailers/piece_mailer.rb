class PieceMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.piece_mailer.new_piece.subject
  #
  def new_piece
    @piece = params[:piece]
    mail to: params[:subscriber].email,
         subject: "New Piece Available: #{@piece.title}"
  end

  def welcome_email
    mail to: params[:subscriber].email,
         subject: "Subscribed to R.W. Writing Corner"
  end
end
