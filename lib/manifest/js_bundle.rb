require_relative "sub"

module Staticz
  class JSBundle
    attr_reader :name, :location, :elements

    def initialize(name, location)
      @name = name
      @location = location
      @elements = []
    end

    def sub(name, &block)
      s = Staticz::Sub.new("#{location}/#{name}")
      elements.push(s)
      s.instance_eval(&block)
    end

    def js(name, &block)
      elements.push(Staticz::Compilable::Js.new("#{location}/#{name}"))
    end

    def coffee(name, &block)
      elements.push(Staticz::Compilable::Cs.new("#{location}/#{name}"))
    end

    def react(name, &block)
      elements.push(Staticz::Compilable::React.new("#{location}/#{name}"))
    end

    def build
      File.write "build/#{name}_bundle.js", render
    end

    def render
      render_elements elements
    end

    def render_elements(elements)
      elements
        .map do |element|
          if element.is_a? Staticz::Sub
            render_elements element.elements
          else
            [
              "// #{element.name}",
              element.render
            ].join("\n\n")
          end
        end
        .join("\n\n")
    end

    def path_method_name
      "#{name.to_s.gsub(/[.\/-]/, "_")}_js_bundle_path"
    end

    def create_link_function
      link_path = "/#{name}_bundle.js"

      Object.send(:define_method, path_method_name) do
        link_path
      end
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ JSBundle: #{name} -> #{path_method_name}"
      elements.each do |e|
        e.print(indentation + 1)
      end
    end

    def path
      "src/#{name}"
    end
  end
end