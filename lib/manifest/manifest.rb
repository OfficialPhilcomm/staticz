require 'singleton'
require_relative 'compilable'
require_relative 'sub'
require_relative 'haml'
require_relative 'sass'
require_relative 'scss'
require_relative 'js'
require_relative 'cs'
require_relative 'react'

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
      elements.push(Staticz::Haml.new(name))
    end

    def sass(name)
      elements.push(Staticz::Sass.new(name))
    end

    def scss(name)
      elements.push(Staticz::Scss.new(name))
    end

    def js(name)
      elements.push(Staticz::Js.new(name))
    end

    def coffee(name)
      elements.push(Staticz::Cs.new(name))
    end

    def react(name)
      elements.push(Staticz::React.new(name))
    end

    def build
      load "#{Dir.pwd}/manifest.rb"

      elements.each do |e|
        e.create_link_function
      end

      elements.each do |e|
        e.build
      end

      print
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
