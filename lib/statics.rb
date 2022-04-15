require_relative 'server'
require_relative 'builder'
require_relative 'helpers'

module Statics
  def self.init
    if ARGV[0] && ARGV[0].downcase == 'server'
      Statics::Server.new
    else
      Statics::Builder.new
    end
  end
end
