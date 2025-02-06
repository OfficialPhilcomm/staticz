require_relative "../compilable"

module Staticz
  module Compilable
    class SimpleFile
      include Compilable

      compile "", "", "File"

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

        Manifest.instance.functions << path_method_name
      end

      def initialize(name)
        @name = name
      end

      def build(listener_class: nil)
        listener = listener_class&.new(self)

        if exists?
          File.write build_path, File.read(source_path)

          listener&.finish
        else
          listener&.error
        end
      end
    end
  end
end
