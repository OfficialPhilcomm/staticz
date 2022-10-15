require "coffee-script"
require_relative "../compilable"

module Staticz
  module Compilable
    class Cs
      include Compilable

      attr_reader :name

      compile "coffee", "js", "Coff"

      def initialize(name)
        @name = name
      end

      def build(listener_class: nil)
        listener = listener_class&.new(self)

        if exists?
          File.write build_path, render

          listener&.finish
        else
          listener&.error
        end
      end

      def render
        CoffeeScript.compile File.read(source_path)
      end
    end
  end
end
