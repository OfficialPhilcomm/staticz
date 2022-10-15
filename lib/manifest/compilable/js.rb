require_relative "../compilable"

module Staticz
  module Compilable
    class Js
      include Compilable

      attr_reader :name

      compile "js", "js", "Js"

      def initialize(name)
        @name = name
      end

      def build(listener_class: nil)
        if exists?
          listener = listener_class&.new(self)

          File.write build_path, render

          listener&.finish
        end
      end

      def render
        File.read(source_path)
      end
    end
  end
end
