module Statics
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

    def valid
      if exists?
        Colors.in_green("✔")
      else
        Colors.in_red("✘ (file does not exist)")
      end
    end

    def create_link_function
      link_path = "#{name}.#{build_file_ending}"
      Object.send(:define_method, path_method_name) { link_path }
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ #{tile_type_name}: #{path} #{valid} -> #{path_method_name}"
    end
  end
end
