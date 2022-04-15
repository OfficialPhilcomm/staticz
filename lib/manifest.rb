require 'singleton'

module Statics
  class Manifest
    include Singleton

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
        e.print(0)
      end
    end
  end

  class Sub
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def haml(name, &block)
      elements.push(Statics::Haml.new("#{@name}/#{name}"))
    end

    def sub(name, &block)
      s = Statics::Sub.new("#{@name}/#{name}")
      elements.push(s)
      s.instance_eval(&block)
    end

    def print(indentation)
      puts "#{" " * indentation}↳Sub: #{path}"
      elements.each do |e|
        e.print(indentation + 1)
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

    def print(indentation)
      puts "#{" " * indentation}↳Haml: #{path}"
    end
  end
end

def haml(name)
  Statics::Manifest.instance.haml(name)
end

def sub(name, &block)
  s = Statics::Manifest.instance.sub(name)

  s.instance_eval(&block)
end

require "#{Dir.pwd}/manifest.rb"

Statics::Manifest.instance.print
