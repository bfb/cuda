module Cuda
  class Request
    def initialize(content)
      @method, @path, @version = content.split(' ')
      @headers = parse_headers(content)
    end

    attr_accessor :method, :path, :version, :headers

    def parse_headers(content)
      headers = {}
      content.split("\r\n")[1..-1].each do |header|
        key, value = header.split(":")
        headers[key] = value
      end
      headers
    end

  end
end