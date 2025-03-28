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
      s = Staticz::Sub.new(generate_location_path(name))
      elements.push(s)
      s.instance_eval(&block)
    end

    def js(name, &block)
      elements.push(Staticz::Compilable::Js.new(generate_location_path(name)))
    end

    def coffee(name, &block)
      elements.push(Staticz::Compilable::Cs.new(generate_location_path(name)))
    end

    def react(name, &block)
      elements.push(Staticz::Compilable::React.new(generate_location_path(name)))
    end

    def generate_location_path(name)
      if location.empty?
        name
      else
        "#{location}/#{name}"
      end
    end

    def build(listener_class: nil)
      listener = listener_class&.new(self)

      File.write "build/#{name}_bundle.js", render

      listener&.finish
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

      Manifest.instance.functions << path_method_name
    end

    def valid?
      elements.map do |e|
        e.valid?
      end
    end

    def print(indentation)
      puts "#{" " * (indentation * 3)}└─ JSBundle: #{name} -> #{path_method_name}"
      elements.each do |e|
        e.print(indentation + 1, :no_path)
      end
    end

    def path
      "src/#{name}"
    end
  end
end
