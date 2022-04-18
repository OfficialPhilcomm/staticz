require "babel/transpiler"
require_relative "../compilable"

module Staticz
  module Compilable
    class React
      include Compilable

      attr_reader :name

      def source_file_ending = "js"

      def build_file_ending = "js"

      def tile_type_name = "React"

      def initialize(name)
        @name = name
      end

      def build
        if exists?
          engine = Babel::Transpiler.transform File.read(source_path)

          File.write build_path, engine["code"]
        end
      end
    end
  end
end
