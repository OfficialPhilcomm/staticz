require_relative "modules/lib_loader"

module Staticz
  class Builder
    def initialize
      build
    end

    private

    def build
      Staticz::Modules::LibLoader.load_files

      Dir.mkdir('build') unless File.exist?('build')

      Staticz::Manifest.instance.build
    end
  end
end
