module Statics
  class Manifest
    attr_reader :elements

    def initialize
      @elements = []
    end

    def sub(name)
      s = Statics::Sub.new(name)
      elements.push(s)
      s
    end

    def haml(name)
      elements.push(Statics::Haml.new(name))
    end

    def print
      puts "Manifest:"
      elements.each do |e|
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
      elements.push(Statics::Haml.new("#{@name}/#{name}"))
    end

    def sub(name)
      s = Statics::Sub.new("#{@name}/#{name}")
      elements.push(s)
      yield s
    end

    def print
      puts "Sub: #{path}"
      elements.each do |e|
        e.print
      end
    end

    def path
      "src/#{name}"
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
  s = @manifest.sub(name)

  yield s
end

require "#{Dir.pwd}/manifest.rb"

@manifest.print
