require "singleton"
require_relative "sub"
require_relative "compilable/haml"
require_relative "compilable/cs"
require_relative "compilable/js"
require_relative "compilable/react"
require_relative "compilable/sass"
require_relative "compilable/scss"
require_relative "compilable/simple_file"

module Staticz
  class Manifest
    include Singleton

    attr_reader :elements

    def initialize
      @elements = []
    end

    def sub(name, &block)
      s = Staticz::Sub.new(name)
      elements.push(s)

      s.instance_eval(&block)
    end

    def haml(name)
      elements.push(Staticz::Compilable::Haml.new(name))
    end

    def sass(name)
      elements.push(Staticz::Compilable::Sass.new(name))
    end

    def scss(name)
      elements.push(Staticz::Compilable::Scss.new(name))
    end

    def js(name)
      elements.push(Staticz::Compilable::Js.new(name))
    end

    def coffee(name)
      elements.push(Staticz::Compilable::Cs.new(name))
    end

    def react(name)
      elements.push(Staticz::Compilable::React.new(name))
    end

    def file(name)
      elements.push(Staticz::Compilable::SimpleFile.new(name))
    end

    def build
      load "#{Dir.pwd}/manifest.rb"

      create_link_functions

      elements.each do |e|
        e.build
      end
    end

    def create_link_functions
      elements.each do |e|
        e.create_link_function
      end
    end

    def self.define(&block)
      Staticz::Manifest.instance.define(block)
    end

    def define(block)
      elements.clear
      instance_eval(&block)
    end

    def print
      puts "Manifest:"
      elements.each do |e|
        e.print(0)
      end
    end
  end
end
