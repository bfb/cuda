module Cuda
  class Handler

    def initialize(session)
      puts "INITIALIZING HANDLER"
      puts $http_version
      @session = session
    end

    def serve
      #loop do
        request = Cuda::Request.new(receive)
        response = Cuda::Response.new(request)

        @session.puts response.serve
      #end
      @session.close
    end

    def receive
      request = ""
      loop do
        get = @session.gets
        break if get.chomp.empty?
        request << get
      end
      request
    end

  end
end