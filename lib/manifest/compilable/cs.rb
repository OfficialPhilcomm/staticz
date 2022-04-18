require "coffee-script"
require_relative "../compilable"

module Staticz
  module Compilable
    class Cs
      include Compilable

      attr_reader :name

      def source_file_ending = "coffee"

      def build_file_ending = "js"

      def tile_type_name = "Coff"

      def initialize(name)
        @name = name
      end

      def build
        if exists?
          js = CoffeeScript.compile File.read(source_path)

          File.write build_path, js
        end
      end
    end
  end
end
