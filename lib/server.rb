require "thin"
require "listen"
require "io/console"

require_relative "manifest/manifest"
require_relative "modules/reload"

module Staticz
  class Server
    def initialize
      Thin::Logging.silent = true

      app = Rack::Builder.new do
        map "/reload.js" do
          run lambda { |env|
            [
              200,
              {"Content-Type" => "text/plain"},
              Staticz::Modules::Reload.build_reload_js
            ]
          }
        end
        map "/api/hash" do
          run lambda { |env|
            [
              200,
              {"Content-Type" => "text/plain"},
              Staticz::Modules::Reload.hash
            ]
          }
        end
        map "/" do
          use Rack::Static, urls: {"/" => "build/index.html"}

          Staticz::Server.all_haml(Staticz::Manifest.instance.elements).each do |e|
            use Rack::Static, urls: {"/#{e.name}" => e.build_path}
          end

          run Rack::Directory.new("build")
        end
      end

      thin_server = Thin::Server.new '127.0.0.1', 3000
      thin_server.app = app

      build_manifest

      Thread.new { listen_to_file_changes }
      Thread.new { listen_to_manifest_changes }
      thin_server.start
    end

    def self.all_haml(elements)
      elements.map do |e|
        if e.is_a? Staticz::Compilable::Haml
          e
        elsif e.is_a? Staticz::Sub
          all_haml(e.elements)
        end
      end.flatten.select do |e|
        e
      end
    end

    private

    def listen_to_file_changes
      folders = ["src"]
      folders << "lib" if Dir.exist? "lib"

      listener = Listen.to(*folders) do |modified, added, removed|
        trigger_rebuild(modified, added, removed)
      end
      listener.start
    end

    def listen_to_manifest_changes
      listener = Listen.to("./", only: /^manifest.rb$/) do |modified, added, removed|
        trigger_rebuild(modified, added, removed)
      end
      listener.start
    end

    def trigger_rebuild(modified, added, removed)
      file_names = (modified + added + removed)
        .map do |file|
          file.gsub "#{Dir.pwd}/", ""
        end
        .join(", ")

      $stdout.clear_screen
      puts "#{file_names} changed, rebuilding..."
      build_manifest
      puts "Rebuilding successful"
    end

    def build_manifest
      Staticz::Builder.new
      Staticz::Manifest.instance.print

      Staticz::Modules::Reload.generate_hash
    end
  end
end
