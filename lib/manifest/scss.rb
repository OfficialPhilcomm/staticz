require 'sassc'

module Statics
  class Scss
    include Compilable

    attr_reader :name

    def source_file_ending = "scss"

    def build_file_ending = "css"

    def tile_type_name = "Scss"

    def initialize(name)
      @name = name
    end

    def build
      if exists?
        engine = ::SassC::Engine.new(File.read(source_path), syntax: :scss, style: :compressed)

        File.write build_path, engine.render
      end
    end
  end
end
