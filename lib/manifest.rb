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

    def to_s
      manifest.map(&:to_s).join('\n')
    end
  end

  class Sub
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      name
    end

    def haml
      puts "really?"
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

    def to_s
      "src/#{name}.haml"
    end
  end
end

@manifest = Statics::Manifest.new

def haml(name)
  @manifest.haml(name)
end

def sub(name)
  @manifest.sub(name)
end

require "#{Dir.pwd}/manifest.rb"

puts "Manifest:"
puts @manifest
