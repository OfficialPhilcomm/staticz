module Statics
  class Haml
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      "src/#{name}.haml"
    end

    def build
      if exists?
        engine = ::Haml::Engine.new(File.read(path))
  
        File.write "build/#{name}.html", engine.render
      end
    end

    def exists?
      File.exist? path
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ Haml: #{path} #{valid}"
    end

    def valid
      if exists?
        Colors.in_green("✔")
      else
        Colors.in_red("✘")
      end
    end
  end
end
