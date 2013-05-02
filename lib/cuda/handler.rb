module Cuda
  class Handler

    def initialize(session)
      puts "INITIALIZING HANDLER"
      puts $http_version
      @session = session
    end

    def serve
      loop do
        # run it in threads
        IO.select([@session], nil, nil, 6) or fail 'Connection timed out'

        request = Cuda::Request.new(receive)
        puts "REQUEST: #{request.inspect}"
        response = Cuda::Response.new(request)
        puts "RESPONSE"
        @session.puts response.serve
      end
    rescue
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