require "singleton"
require_relative "sub"
require_relative "compilable/haml"
require_relative "compilable/cs"
require_relative "compilable/js"
require_relative "compilable/react"
require_relative "compilable/scss"
require_relative "compilable/simple_file"
require_relative "js_bundle"
require_relative "css_bundle"

module Staticz
  class Manifest
    include Singleton

    attr_reader :elements, :functions

    def initialize
      @elements = []
      @functions = []
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
      elements.push(Staticz::Compilable::Scss.new(name, type: :sass))
    end

    def scss(name)
      elements.push(Staticz::Compilable::Scss.new(name, type: :scss))
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

    def js_bundle(name, &block)
      s = Staticz::JSBundle.new(name, "")
      elements.push(s)

      s.instance_eval(&block)
    end

    def css_bundle(name, &block)
      s = Staticz::CSSBundle.new(name, "")
      elements.push(s)

      s.instance_eval(&block)
    end

    def build(listener_class: nil)
      load "#{Dir.pwd}/manifest.rb"

      create_link_functions

      elements.each do |e|
        e.build(listener_class: listener_class)
      end
    end

    def create_link_functions
      elements.each do |e|
        e.create_link_function
      end
    end

    def valid?
      elements.map do |e|
        e.valid?
      end
    end

    def self.define(&block)
      Staticz::Manifest.instance.define(block)
    end

    def define(block)
      elements.clear

      functions.each do |function|
        Object.send(:undef_method, function)
      end
      functions.clear

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
