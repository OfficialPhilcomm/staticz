module Statics
  class Sub
    attr_reader :name, :elements
  
    def initialize(name)
      @name = name
      @elements = []
    end
  
    def haml(name, &block)
      elements.push(Statics::Haml.new("#{@name}/#{name}"))
    end
  
    def sub(name, &block)
      s = Statics::Sub.new("#{@name}/#{name}")
      elements.push(s)
      s.instance_eval(&block)
    end
  
    def build
      elements.each do |e|
        e.build
      end
    end
  
    def print(indentation)
      puts "#{" " * indentation}↳Sub: #{path}"
      elements.each do |e|
        e.print(indentation + 1)
      end
    end
  
    def path
      "src/#{name}"
    end
  end  
end
