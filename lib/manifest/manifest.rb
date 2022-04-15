require_relative 'sub'
require_relative 'haml'
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

    def build
      require "#{Dir.pwd}/manifest.rb"

      elements.each do |e|
        e.build
      end

      print
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

def haml(name)
  Statics::Manifest.instance.haml(name)
end

def sub(name, &block)
  s = Statics::Manifest.instance.sub(name)

  s.instance_eval(&block)
end
