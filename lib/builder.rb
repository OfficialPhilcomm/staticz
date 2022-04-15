require "haml"

module Statics
  class Builder
    def initialize
      build
    end

    private

    def build
      Dir.mkdir('build') unless File.exist?('build')

      Statics::Manifest.instance.build
    end
  end
end
