require_relative "template"
require_relative "server"
require_relative "builder"
require_relative "settings"
require_relative "utils/colors"
require_relative "utils/helpers"

module Staticz
  def self.init
    usage = [
      "Usage: staticz <mode>",
      "",
      "  new [name]",
      "  server",
      "  manifest",
      "  build"
    ].join("\n")

    case ARGV[0]
    when 'new'
      if ARGV[1]
        Staticz::Template.new(ARGV[1])
      else
        puts usage
      end
    when 'server'
      Staticz::Settings.development!
      Staticz::Server.new
    when 'manifest'
      load "#{Dir.pwd}/manifest.rb"
      Staticz::Manifest.instance.print
    when 'build'
      Staticz::Settings.production!
      Staticz::Builder.new
    else
      puts usage
    end
  end
end
