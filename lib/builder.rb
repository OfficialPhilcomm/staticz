require "tty-spinner"
require_relative "modules/lib_loader"
require_relative "manifest/manifest"

module Staticz
  class Builder
    def initialize(listener_class: nil)
      build(listener_class: listener_class)
    end

    private

    def build(listener_class: nil)
      Staticz::Modules::LibLoader.load_files

      Dir.mkdir('build') unless File.exist?('build')

      Staticz::Manifest.instance.build(listener_class: listener_class)
    end
  end
end
