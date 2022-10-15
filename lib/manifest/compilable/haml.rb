require "haml"
require_relative "../compilable"

module Staticz
  module Compilable
    class Haml
      include Compilable

      attr_reader :name

      compile "haml", "html", "Haml"

      def initialize(name)
        @name = name
      end

      def errors
        errors = super

        if exists?
          begin
            engine = ::Haml::Engine.new(File.read(source_path))
            engine.render
          rescue => e
            errors << e.message
          end
        end

        errors
      end

      def build(listener_class: nil)
        listener = listener_class&.new(self)

        if valid?
          engine = ::Haml::Engine.new(File.read(source_path))
          File.write build_path, engine.render

          listener&.finish
        else
          listener&.error
        end
      end
    end
  end
end
