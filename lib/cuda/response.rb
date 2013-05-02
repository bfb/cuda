require 'date'
module Cuda

  class Response

    #
    # Build a valid response based in the given request
    #
    def initialize(request)
      @path = request.path
      @version = request.version
      @headers = request.headers
      build
    end

    attr_accessor :path, :version, :status, :body, :headers

    def serve
      response = "HTTP/1.1 #{@status[:message]}\r\n"

      @headers.each do |key, value|
        response << "#{key}: #{value}\r\n"
      end

      response << "Date: #{DateTime.now.httpdate}\r\n"
      response << "Server: Cuda Server - version 0.0.1\r\n"
      response << "Content-Type: text/html\r\n\r\n"
      response << @body

      response
    end

    private

      def build
        if File.directory?(relative_path)
          # Show page with all directories/files
        elsif File.exist?(relative_path)
          # Lets serve this file
          @status = Cuda::Server.errors[200]
          @body = File.new(relative_path).read
        else
          @status = Cuda::Server.errors[404]
          @body = File.new("/Users/brunobohn/Projects/cuda/public/404.html").read
        end
      end

      def relative_path
        "#{$dir}#{@path}"
      end

  end

end