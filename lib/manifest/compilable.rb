module Statics
  module Compilable
    def path
      name
    end

    def source_path
      "src/#{name}.#{source_file_ending}"
    end

    def build_path
      "build/#{name}.#{build_file_ending}"
    end

    def link_path
      "#{name}.#{build_file_ending}"
    end

    def exists?
      File.exist? source_path
    end

    def valid
      if exists?
        Colors.in_green("✔")
      else
        Colors.in_red("✘")
      end
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ #{tile_type_name}: #{path} #{valid}"
    end
  end
end
