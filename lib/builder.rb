require "haml"

module Staticz
  class Builder
    def initialize
      build
    end

    private

    def build
      Dir.mkdir('build') unless File.exist?('build')

      Staticz::Manifest.instance.build
    end
  end
end
