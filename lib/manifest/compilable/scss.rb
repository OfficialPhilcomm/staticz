require "sassc"
require_relative "../compilable"

module Staticz
  module Compilable
    class Scss
      include Compilable

      attr_reader :name

      def source_file_ending = "scss"

      def build_file_ending = "css"

      def tile_type_name = "Scss"

      def initialize(name)
        @name = name
      end

      def build
        if valid?
          engine = ::SassC::Engine.new(File.read(source_path), syntax: :scss, style: :compressed)

          File.write build_path, engine.render
        end
      end

      def errors
        errors = super

        if exists?
          begin
            engine = ::SassC::Engine.new(File.read(source_path), syntax: :scss)
            engine.render
          rescue => e
            errors << e.message
          end
        end

        errors
      end
    end
  end
end
