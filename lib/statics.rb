require_relative 'manifest/manifest'
require_relative 'server'
require_relative 'builder'
require_relative 'helpers'
require_relative 'colors'

module Statics
  def self.init
    if ARGV[0] && ARGV[0].downcase == 'server'
      Statics::Server.new
    else
      Statics::Builder.new
    end
  end
end
