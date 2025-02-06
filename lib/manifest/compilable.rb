require "io/console"
require_relative "../utils/colors"

module Staticz
  module Compilable
    def self.included(base)
      base.extend(ClassMethods)
    end
    module ClassMethods
      def compile(source_file_ending, build_file_ending, file_type_name)
        define_method :source_file_ending do
          source_file_ending
        end

        define_method :build_file_ending do
          build_file_ending
        end

        define_method :file_type_name do
          file_type_name
        end
      end
    end

    def path
      name.to_s
    end

    def source_path
      "src/#{name}.#{source_file_ending}"
    end

    def build_path
      "build/#{name}.#{build_file_ending}"
    end

    def exists?
      File.exist? source_path
    end

    def path_method_name
      "#{path.gsub(/[\s.\/-]+/, "_").downcase}_path"
    end

    def valid?
      errors.empty?
    end

    def errors
      errors = []

      errors << "File does not exist" if !exists?

      errors
    end

    def create_link_function
      link_path = "/#{name}.#{build_file_ending}"
      shortened_link_path = "/#{name}"
      Object.send(:define_method, path_method_name) do |shorten: false|
        if shorten
          shortened_link_path
        else
          link_path
        end
      end
      Manifest.instance.functions << path_method_name
    end

    def print(indentation, *args)
      valid_symbol = if valid?
        Colors.in_green("✔")
      else
        Colors.in_red("✘")
      end

      compilable_string = "#{" " * (indentation * 3)}└─ #{file_type_name}: #{path} #{valid_symbol}"
      compilable_string << " -> #{path_method_name}" if !args.include? :no_path

      puts compilable_string

      _height, width = IO.console.winsize

      errors.each do |full_error|
        line_width = width - (indentation * 3) - 3
        multiline_errors = full_error.scan(/.{1,#{line_width}}/)
        multiline_errors.each do |error|
          puts "#{" " * (indentation * 3)}   #{Colors.in_red(error)}"
        end
      end
    end
  end
end
