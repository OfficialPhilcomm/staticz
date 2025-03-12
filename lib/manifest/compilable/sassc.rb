require "sass-embedded"
require "pastel"
require_relative "../compilable"

module Staticz
  module Compilable
    class SassC
      include Compilable

      attr_reader :name

      compile "sass", "css", "Sass"

      def initialize(name)
        @name = name
        @warnings = []
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

      def debug(message, options)
        warn(message, debug)
      end

      def warn(message, options)
        pastel = Pastel.new

        line = options.span.start.line + 1
        start_index = options.span.start.column
        end_index = options.span.end.column

        @warnings << <<~WARNING
          #{pastel.yellow.bold("Warning")}: #{message}

          #{" " * line.to_s.size} #{pastel.blue("╷")}
          #{pastel.blue(line)} #{pastel.blue("│")} #{pastel.red(options.span.context.strip)}
          #{" " * line.to_s.size} #{pastel.blue("│")} #{" " * start_index}#{pastel.red("^" * (end_index - start_index))}
          #{" " * line.to_s.size} #{pastel.blue("╵")}

          #{options.stack}
        WARNING
      end

      def warnings
        if valid?
          Sass.compile(source_path, style: :compressed, logger: self)
        end

        @warnings
      end
    end
  end
end
