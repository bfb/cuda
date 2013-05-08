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
        assets = []
        assets << Nokogiri::HTML(get).css("img")
        assets << Nokogiri::HTML(get).css("link")
        assets << Nokogiri::HTML(get).css("script")

        assets.flatten.each do |asset|
          Thread.new do
            if asset.attributes.has_key?('src')
              get_asset(asset.attributes['src'].value)
            else
              get_asset(asset.attributes['href'].value)
            end
          end
        end unless assets.flatten.empty?

        break if get.nil?
      end

    end

    def get_asset(asset)
      asset = asset[0] == "/" ? asset[1..-1] : asset
      @socket.puts "GET /#{asset} HTTP/1.1"
      @socket.puts ""
    end

  end
end