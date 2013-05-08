module Cuda
  class Handler

    def initialize(session)
      @session = session
    end

    def serve
      loop do
        IO.select([@session], nil, nil, 6) or fail 'Connection timed out'
        input = receive

        unless input.nil?
          request = Cuda::Request.new(input)
          if request.path
            Cuda::Logger.print(request)

            response = Cuda::Response.new(request)
            Cuda::Logger.print(response)

            @session.puts response.serve
          end
        end
      end
    rescue Exception => e
      # puts e.inspect
      # puts e.backtrace

      @session.close
    end

    def receive
      request = ""
      loop do
        get = @session.gets

        break if get.nil? || get.chomp.empty?
        request << get
      end

      request
    end

  end
end