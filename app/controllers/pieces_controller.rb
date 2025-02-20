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

      rtf_content = URI.open(piece.textsource).read
      preview_text = PandocRuby.convert(rtf_content, :from => :rtf, :to => :plain)

      timestamp = piece.created_at

      charindex = 450
      lastchar = preview_text[charindex]

      while lastchar != ' '
        charindex += 1
        lastchar = preview_text[charindex]
      end
      
      @preview_text[piece.title] = preview_text[0, charindex] + "..."


      #recent text preview
      if (timestamp > mostrecent)
        @recent = piece
        mostrecent = timestamp

        charindex = 450
        lastchar = preview_text[charindex]
  
        while lastchar != ' '
          charindex += 1
          lastchar = preview_text[charindex]
        end

        @recent_preview_text = preview_text[0, charindex] + "..."
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

  end
end
