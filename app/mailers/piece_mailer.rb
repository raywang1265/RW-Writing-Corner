class PieceMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.piece_mailer.new_piece.subject
  #
  def new_piece
    @piece = params[:piece].form.downcase
    mail to: params[:subscriber].email
  end
end
