require "tty-spinner"
require_relative "modules/lib_loader"
require_relative "manifest/manifest"

module Staticz
  class Builder
    def initialize(listener_class: nil)
      @listener_class = listener_class
    end

    def build
      if !manifest_exists?
        puts "Manifest missing"
        exit 1
      end

      if !src_folder_exists?
        puts "src folder missing"
        exit 1
      end

      Staticz::Modules::LibLoader.load_files

      Dir.mkdir('build') unless File.exist?('build')

      Staticz::Manifest.instance.build(listener_class: @listener_class)

      Staticz::Manifest.instance.valid?
    end

    private

    def manifest_exists?
      File.exist? "manifest.rb"
    end

    def src_folder_exists?
      Dir.exist? "src"
    end
  end
end
