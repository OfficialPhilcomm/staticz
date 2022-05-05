require "thin"
require "listen"
require "io/console"

require_relative "manifest/manifest"

module Staticz
  class Server
    def initialize
      Thin::Logging.silent = true

      app = Rack::Builder.new do
        map "/" do
          use Rack::Static, urls: {"/" => "build/index.html"}
          run Rack::Directory.new("build")
        end
      end

      thin_server = Thin::Server.new '127.0.0.1', 3000
      thin_server.app = app

      build_manifest

      Thread.new { listen_to_file_changes }
      thin_server.start
    end

    private

    def listen_to_file_changes
      listener = Listen.to('src') do |modified, added, removed|
        file_names = (modified + added + removed)
          .map do |file|
            file.gsub "#{Dir.pwd}/src/", ""
          end
          .join(", ")

        $stdout.clear_screen
        puts "#{file_names} changed, rebuilding..."
        build_manifest
        puts "Rebuilding successful"
      end
      listener.start
    end

    def build_manifest
      Staticz::Builder.new
      Staticz::Manifest.instance.print
    end
  end
end
