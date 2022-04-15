require_relative 'sub'
require_relative 'haml'
require_relative 'sass'
require_relative 'scss'
require 'singleton'

module Statics
  class Manifest
    include Singleton

    attr_reader :elements

    def initialize
      @elements = []
    end

    def sub(name, &block)
      s = Statics::Sub.new(name)
      elements.push(s)

      s.instance_eval(&block)
    end

    def haml(name)
      elements.push(Statics::Haml.new(name))
    end

    def sass(name)
      elements.push(Statics::Sass.new(name))
    end

    def scss(name)
      elements.push(Statics::Scss.new(name))
    end

    def build
      require "#{Dir.pwd}/manifest.rb"

      elements.each do |e|
        e.build
      end

      print
    end

    def self.define(&block)
      Statics::Manifest.instance.define(block)
    end

    def define(block)
      instance_eval(&block)
    end

    def print
      puts ""
      puts "Manifest:"
      elements.each do |e|
        e.print(0)
      end
    end
  end
end
