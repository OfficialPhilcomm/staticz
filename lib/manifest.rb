module Statics
  class Manifest
    attr_reader :manifest

    def initialize
      @manifest = []
    end

    def sub(name)
      manifest.push(Statics::Sub.new(name))
    end

    def haml(name)
      manifest.push(Statics::Haml.new(name))
    end

    def print
      puts "Manifest:"
      manifest.each do |e|
        e.print
      end
    end
  end

  class Sub
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def haml(name)
      puts "finally"
      elements.push(Statics::Haml.new(name))
    end

    def print
      puts "Sub: #{name}"
      elements.each do |e|
        e.print
      end
    end
  end

  class Haml
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      "src/#{name}.haml"
    end

    def print
      puts "Haml: #{path}"
    end
  end
end

@manifest = Statics::Manifest.new

def haml(name)
  @manifest.haml(name)
end

def sub(name)
  @manifest.sub(name)

  yield
end

require "#{Dir.pwd}/manifest.rb"

@manifest.print
