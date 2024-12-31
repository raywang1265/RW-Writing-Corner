require "test_helper"

class PieceMailerTest < ActionMailer::TestCase
  test "new_piece" do
    mail = PieceMailer.new_piece
    assert_equal "New piece", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
