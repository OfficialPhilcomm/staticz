require_relative "../compilable"

module Staticz
  module Compilable
    class SimpleFile
      include Compilable

      attr_reader :name

      def source_path
        "src/#{name}"
      end

      def build_path
        "build/#{name}"
      end

      def create_link_function
        link_path = "/#{name}"
        Object.send(:define_method, path_method_name) { link_path }
      end

      def tile_type_name = "File"

      def initialize(name)
        @name = name
      end

      def build
        if exists?
          File.write build_path, File.read(source_path)
        end
      end
    end
  end
end
