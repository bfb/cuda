module Cuda
  class Server

    #
    # start the server in the specified directory and port
    # verify if the directory is valid and handle all clients to an object Handler
    # default port: 3000
    # default dir: ./
    #
    def initialize(dir, port)
      fail "Invalid path" unless File.directory?(dir)
      @port = port
      @dir = dir
      start
    end

    def start
      server = TCPServer.new(@port)

      loop do
        session = server.accept
        Thread.start(session) do |session|
          Cuda::Handler.new(session).serve
        end
     end
    end

    attr_reader :dir, :port

    def self.statuses
      {
        404 => { :code => 404, :message => "404 Not found" },
        200 => { :code => 200, :message => "200 OK" }
      }
    end

  end
end