require 'open-uri'
require 'pandoc-ruby' 

class PiecesController < ApplicationController
  def index
    @pieces = Piece.all
  end

  def show
    @piece = Piece.find_by(titleurl: params[:titleurl])
    # Read the RTF file from the source (local or remote)
    rtf_content = URI.open(@piece.textsource).read

    # Parse the RTF content
    @text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :html)
    @preview_text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :plain)

  end
end
