require "sass-embedded"
require_relative "../compilable"

module Staticz
  module Compilable
    class ScssC
      include Compilable

      attr_reader :name

      compile "scss", "css", "Scss"

      def initialize(name)
        @name = name
      end

      def build(listener_class: nil)
        listener = listener_class&.new(self)

        if valid?
          File.write build_path, render

          listener&.finish
        else
          listener&.error
        end
      end

      def render
        Sass.compile(source_path, style: :compressed).css
      end

      def errors
        errors = super

        if exists?
          begin
            Sass.compile(source_path, style: :compressed).css
          rescue => e
            errors << e.message
          end
        end

        errors
      end
    end
  end
end
