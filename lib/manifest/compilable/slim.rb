require "slim"
require_relative "../compilable"

module Staticz
  module Compilable
    class Slim
      include Compilable

      attr_reader :name

      compile "slim", "html", "Slim"

      def initialize(name)
        @name = name
      end

      def errors
        errors = super

        if exists?
          begin
            template = ::Slim::Template.new(source_path)
            template.render
          rescue => e
            errors << e.message
          end
        end

        errors
      end

      def build(listener_class: nil)
        listener = listener_class&.new(self)

        if valid?
          template = ::Slim::Template.new(source_path)
          File.write build_path, template.render

          listener&.finish
        else
          listener&.error
        end
      end
    end
  end
end
