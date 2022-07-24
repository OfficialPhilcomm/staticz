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

      def build
        if exists?
          File.write build_path, render
        end
      end

      def render
        Babel::Transpiler.transform(File.read(source_path))["code"]
      end
    end
  end
end
