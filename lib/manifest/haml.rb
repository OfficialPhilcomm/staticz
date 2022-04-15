module Statics
  class Haml
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      "src/#{name}.haml"
    end

    def build
      engine = ::Haml::Engine.new(File.read(path))

      File.write "build/#{name}.html", engine.render
    end

    def print(indentation)
      puts "#{" " * indentation}↳Haml: #{path}"
    end
  end
end
