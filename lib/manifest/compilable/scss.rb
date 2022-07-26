require "sassc"
require_relative "../compilable"

module Staticz
  module Compilable
    class Scss
      include Compilable

      attr_reader :name

      compile "scss", "css", "Scss"

      def initialize(name)
        @name = name
      end

      def build
        if valid?
          File.write build_path, render
        end
      end

      def render
        ::SassC::Engine.new(File.read(source_path), syntax: :scss, style: :compressed).render
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
