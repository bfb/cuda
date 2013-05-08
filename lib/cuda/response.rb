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

      response << "Date: #{DateTime.now.httpdate}\r\n"
      response << "Server: Cuda Server - version 0.0.1\r\n"
      response << "Connection: Keep-Alive\r\n"
      response << "Content-Length: #{@body.bytesize}\r\n"
      response << "Content-Type: #{Cuda::Mime.content_type(@path)}\r\n\r\n"

      response << @body
      response
    end

    private

      def build
        if File.directory?(relative_path)
          # it should identify an index.html file in the directory
          @status = Cuda::Server.statuses[200]
          # Show a page with all directories/files
          @body = Cuda::Template.render(:directories, :directories => Dir.entries(relative_path)[2..-1], :directory => @path)
        elsif File.exist?(relative_path)
          # Lets serve this file
          @status = Cuda::Server.statuses[200]
          @body = File.new(relative_path).read
        else
          @status = Cuda::Server.statuses[404]
          @body = Cuda::Template.render(:error, :message => @status[:message])
        end
      end

      def relative_path
        "#{$dir}#{@path}"
      end

  end

end