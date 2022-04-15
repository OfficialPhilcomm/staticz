require 'sassc'

module Statics
  class Scss
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      "src/#{name}.scss"
    end

    def build
      engine = ::SassC::Engine.new(File.read(path), syntax: :scss, style: :compressed)

      File.write "build/#{name}.css", engine.render
    end

    def print(indentation)
      puts "#{" " * indentation}↳Scss: #{path}"
    end
  end
end
