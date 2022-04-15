require 'sassc'

module Statics
  class Sass
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      "src/#{name}.sass"
    end

    def build
      engine = ::SassC::Engine.new(File.read(path))

      File.write "build/#{name}.css", engine.render
    end

    def print(indentation)
      puts "#{" " * indentation}↳Sass: #{path}"
    end
  end
end
