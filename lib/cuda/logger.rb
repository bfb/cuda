require 'logger'

module Cuda

  module Logger
    @log = ::Logger.new(STDOUT)
    @error = ::Logger.new(STDERR)

    def self.print(object)
      @log << "#{object.kind_of?(String) ? object : messages(object)} at #{Time.now}\n"
    end

    def self.messages(object)
      if object.kind_of?(Cuda::Request)
        "Started #{object.method} #{object.path}"
      elsif object.kind_of?(Cuda::Response)
        "Completed #{object.status[:message]}"
      end
    end
  end
end