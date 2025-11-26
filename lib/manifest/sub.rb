module Staticz
  class Sub
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def sub(name, &block)
      s = Staticz::Sub.new("#{@name}/#{name}")
      elements.push(s)
      s.instance_eval(&block) if block_given?
    end

    def haml(name, &block)
      elements.push(Staticz::Compilable::Haml.new("#{@name}/#{name}"))
    end

    def slim(name, &block)
      elements.push(Staticz::Compilable::Slim.new("#{@name}/#{name}"))
    end

    def sass(name, &block)
      elements.push(Staticz::Compilable::Scss.new("#{@name}/#{name}", type: :sass))
    end

    def scss(name, &block)
      elements.push(Staticz::Compilable::Scss.new("#{@name}/#{name}", type: :scss))
    end

    def js(name, &block)
      elements.push(Staticz::Compilable::Js.new("#{@name}/#{name}"))
    end

    def coffee(name, &block)
      elements.push(Staticz::Compilable::Cs.new("#{@name}/#{name}"))
    end

    def react(name, &block)
      elements.push(Staticz::Compilable::React.new("#{@name}/#{name}"))
    end

    def file(name, &block)
      elements.push(Staticz::Compilable::SimpleFile.new("#{@name}/#{name}"))
    end

    def js_bundle(name, &block)
      s = Staticz::JSBundle.new("#{@name}/#{name}", @name)
      elements.push(s)

      s.instance_eval(&block)
    end

    def css_bundle(name, &block)
      s = Staticz::CSSBundle.new("#{@name}/#{name}", @name)
      elements.push(s)

      s.instance_eval(&block)
    end

    def build(listener_class: nil)
      Dir.mkdir("build/#{name}") if !Dir.exist?("build/#{name}")

      elements.each do |e|
        e.build(listener_class: listener_class)
      end
    end

    def create_link_function
      elements.each do |e|
        e.create_link_function
      end
    end

    def valid?
      elements.map do |e|
        e.valid?
      end
    end

    def print(indentation, *args)
      puts "#{" " * (indentation * 3)}└─ Sub: #{name}"
      elements.each do |e|
        e.print(indentation + 1, *args)
      end
    end

    def path
      "src/#{name}"
    end
  end
end
