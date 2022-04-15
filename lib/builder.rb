require "haml"

module Statics
  class Builder
    def initialize
      puts "builder"

      build
    end

    private

    def build
      engine = Haml::Engine.new(File.open("src/index.haml").read)

      Dir.mkdir('build') unless File.exists?('build')
      File.write 'build/index.html', engine.render
    end
  end
end
