require_relative 'manifest/manifest'
require_relative 'template'
require_relative 'server'
require_relative 'builder'
require_relative 'helpers'
require_relative 'colors'

module Statics
  def self.init
    usage = [
      "Usage: statics <mode>",
      "",
      "  new [name]",
      "  server",
      "  build"
    ].join("\n")

    case ARGV[0]
    when 'new'
      if ARGV[1]
        Statics::Template.new(ARGV[1])
      else
        puts usage
      end
    when 'server'
      Statics::Server.new
    when 'build'
      Statics::Builder.new
    else
      puts usage
    end
  end
end
