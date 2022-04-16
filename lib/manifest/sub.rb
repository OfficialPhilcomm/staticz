module Statics
  class Sub
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def sub(name, &block)
      s = Statics::Sub.new("#{@name}/#{name}")
      elements.push(s)
      s.instance_eval(&block)
    end

    def haml(name, &block)
      elements.push(Statics::Haml.new("#{@name}/#{name}"))
    end

    def sass(name, &block)
      elements.push(Statics::Sass.new("#{@name}/#{name}"))
    end

    def scss(name, &block)
      elements.push(Statics::Scss.new("#{@name}/#{name}"))
    end

    def js(name, &block)
      elements.push(Statics::Js.new("#{@name}/#{name}"))
    end

    def build
      Dir.mkdir("build/#{name}") if !Dir.exist?("build/#{name}")

      elements.each do |e|
        e.build
      end
    end

    def create_link_function
      elements.each do |e|
        e.create_link_function
      end
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ Sub: #{path}"
      elements.each do |e|
        e.print(indentation + 1)
      end
    end

    def path
      "src/#{name}"
    end
  end
end
