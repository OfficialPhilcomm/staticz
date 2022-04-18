require "haml"
require_relative "../compilable"

module Staticz
  module Compilable
    class Haml
      include Compilable

      attr_reader :name

      def source_file_ending = "haml"

      def build_file_ending = "html"

      def tile_type_name = "Haml"

      def initialize(name)
        @name = name
      end

      def build
        if exists?
          engine = ::Haml::Engine.new(File.read(source_path))

          File.write build_path, engine.render
        end
      end
    end
  end
end
