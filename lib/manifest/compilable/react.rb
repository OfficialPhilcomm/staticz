require "babel/transpiler"
require_relative "../compilable"

module Staticz
  module Compilable
    class React
      include Compilable

      attr_reader :name

      compile "js", "js", "React"

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
        Babel::Transpiler.transform(File.read(source_path))["code"]
      end
    end
  end
end
