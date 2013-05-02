require 'erb'
require 'ostruct'

module Cuda
  module Template
    def self.render(template, locals = {})
      ERB.new(File.open("templates/#{template}.html.erb").read).result(OpenStruct.new(locals).instance_eval { binding })
    end
  end
end