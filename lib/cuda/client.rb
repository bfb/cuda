require 'httpclient'
require 'nokogiri'


module Cuda
  class Client

    def initialize(uri)
      @uri = URI.parse(uri)
      @socket = TCPSocket.new(@uri.host, @uri.port)
      get
    end

    def get
      @socket.puts "GET #{@uri.path} HTTP/1.1"
      @socket.puts ""
      loop do
        get = @socket.gets

        puts get
        Nokogiri::HTML(get).css("img").each do |asset|
          Thread.new do
            get_asset(asset.attributes['src'].value)
          end
        end
        break if get.nil?
        # if get =~ /finish/
        #   @socket.close
        #   break
        # end
      end

    end

    def get_asset(asset)
      @socket.puts "GET /#{asset} HTTP/1.1"
      @socket.puts ""
    end


    # def get_live(uri)
    #   @uri = URI.parse(uri)

    #   @client = HTTPClient.new
    #   request = @client.get(uri) do |c|
    #     assets = Nokogiri::HTML(c).css("img")
    #     puts "assets: #{assets.inspect}"
    #     assets.each do |asset|
    #       Thread.new do
    #         get_asset(asset.attributes['src'].value)
    #       end
    #     end
    #   end
    #   puts "RECEIVED: #{request}"

    # end

    # def get_asset(uri)
    #   puts "get: #{@uri.host}:#{@uri.port}/#{uri}"
    #   request = @client.get("#{@uri.host}:#{@uri.port}/#{uri}")
    #   puts "ASSET RECEIVED: #{request.http_header.request_uri}"
    # end
  end
end