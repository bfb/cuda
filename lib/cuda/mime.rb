module Cuda
  module Mime

    def self.content_type(path)
      ext = File.extname(path)

      case ext
        when ".txt"
          "text/plain"
        when ".css"
          "text/css"
        when ".jpg"
          "images/jpeg"
        when ".gif"
          "images/gif"
        when ".bmp"
          "images/bmp"
        when ".xml"
          "text/xml"
        when ".xsl"
          "text/xml"
        when ".html" || ".htm"
          "text/html"
      end
    end

  end
end