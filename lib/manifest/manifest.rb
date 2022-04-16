require 'singleton'
require_relative 'compilable'
require_relative 'sub'
require_relative 'haml'
require_relative 'sass'
require_relative 'scss'

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
      load "#{Dir.pwd}/manifest.rb"

      elements.each do |e|
        create_link_function(e)
      end

      elements.each do |e|
        e.build
      end

      print
    end

    def create_link_function(e)
      if e.is_a? Statics::Sub
        e.elements.each do |e|
          create_link_function(e)
        end
      else
        name = e.name.to_s
        puts "method_name: #{name.gsub(/[\/-]/, "_")}"
        Object.send(:define_method, name.gsub(/[\/-]/, "_")) { e.build_path }
      end
    end

    def self.define(&block)
      Statics::Manifest.instance.define(block)
    end

    def define(block)
      elements.clear
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
