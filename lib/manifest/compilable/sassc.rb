require "sass-embedded"
require_relative "../compilable"

module Staticz
  module Compilable
    class SassC
      include Compilable

      attr_reader :name

      compile "sass", "css", "Sass"

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
        Sass.compile(source_path, style: :compressed, logger: Sass::Logger.silent).css
      end

      def errors
        @_errors_cache ||= begin
          errors = super

          if exists?
            begin
              Sass.compile(source_path, style: :compressed, logger: Sass::Logger.silent).css
            rescue => e
              errors << e.message
            end
          end

          errors
        end
      end
    end
  end
end
