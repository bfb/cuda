module Cuda
  class Server

    #
    # Start the server in the directory and port specified
    # Verify if the directory is valid and handle all clients to an object Handler
    # Default port: 3000
    # Default dir: ./
    #
    def initialize(dir, port)
      fail "Invalid path" unless File.directory?(dir)
      @port = port
      @dir = dir
      start
    end

    def start
      clients = []

      server = TCPServer.new(@port)

      loop do
        puts "WAITING CONNECTION"
        session = server.accept
        puts "CONNECTION ACCEPTED"

        Thread.start(session) do |session|
          Cuda::Handler.new(session).serve
        end

      end

    end

    attr_reader :dir, :port

    def self.errors
      {
        404 => { :code => 404, :message => "404 Not found" },
        200 => { :code => 200, :message => "200 OK" }
      }
    end

  end
end