require 'open-uri'
require 'pandoc-ruby' 

class PiecesController < ApplicationController
  def index
    @body_color = "#b6aea2"
    @preview_text = Hash.new
    @recent_preview_text = ""
    @pieces = Piece.all
    mostrecent = Time.at(0)

    @pieces.each do |piece|

      if piece.preview_text == nil
        @preview_text[piece.title] = generate_preview_text(piece)
      else
        @preview_text[piece.title] = piece.preview_text
      end

      timestamp = piece.created_at

      #recent text preview
      if (timestamp > mostrecent)
        @recent = piece
        mostrecent = timestamp

        @recent_preview_text = @preview_text[piece.title]
      end

    end

    respond_to do |format|
      format.html do
        if mobile_device?
          render layout: "mobile", template: "pieces/index_mobile"
        else
          render "index"
        end
      end
    end

  end

  def show
    @body_color = "#f3e8d8"
    @piece = Piece.find_by(titleurl: params[:titleurl])
    # Read the RTF file from the source (local or remote)
    rtf_content = URI.open(@piece.textsource).read

    # Parse the RTF content
    @text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :html)
    @text.gsub!(/<p(?![^>]*class=)([^>]*)>([^<]*\*\*\*[^<]*)<\/p>/, '<p id="asterisks-break"\1>\2</p>')
    #@text.gsub!(/(<p[^>]*>)(?![^<]*\*\*\*)([^<]+)/, '\1&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\2')
    #@preview_text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :plain)
    
    respond_to do |format|
      format.html do
        if mobile_device?
          render layout: "mobile", template: "pieces/index_mobile"
        else
          render "index"
        end
      end
    end

  end

  def generate_preview_text(piece)
    rtf_content = URI.open(piece.textsource).read
    preview_text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :plain)

    charindex = 450
    lastchar = preview_text[charindex]

    while lastchar != ' '
      charindex += 1
      lastchar = preview_text[charindex]
    end

    final_preview_text = preview_text[0, charindex] + "..."
    
    piece.update!(preview_text: final_preview_text)
    return final_preview_text
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
end
