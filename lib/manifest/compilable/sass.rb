require "sassc"
require_relative "../compilable"

module Staticz
  module Compilable
    class Sass
      include Compilable

      attr_reader :name

      def source_file_ending = "sass"

      def build_file_ending = "css"

      def tile_type_name = "Sass"

      def initialize(name)
        @name = name
      end

      def build
        if exists?
          engine = ::SassC::Engine.new(File.read(source_path), syntax: :sass, style: :compressed)

          File.write build_path, engine.render
        end
      end
    end
  end
end
