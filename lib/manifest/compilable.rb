require "io/console"

module Staticz
  module Compilable
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
      "#{path.gsub(/[\/-]/, "_")}_path"
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
    end

    def print(indentation)
      valid_symbol = if valid?
        Colors.in_green("✔")
      else
        Colors.in_red("✘")
      end

      puts "#{" " * (indentation * 3)}└─ #{tile_type_name}: #{path} #{valid_symbol} -> #{path_method_name}"

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
