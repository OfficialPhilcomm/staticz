require_relative 'manifest/manifest'
require_relative 'server'
require_relative 'builder'
require_relative 'helpers'
require_relative 'colors'

module Statics
  def self.init
    case ARGV[0]
    when 'server'
      Statics::Server.new
    when 'build'
      Statics::Builder.new
    else
      puts "Usage: statics [server|build]"
    end
  end
end
