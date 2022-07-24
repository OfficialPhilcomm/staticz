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

      def build
        if exists?
          File.write build_path, render
        end
      end

      def render
        CoffeeScript.compile File.read(source_path)
      end
    end
  end
end
