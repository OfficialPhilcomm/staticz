module Statics
  class Js
    include Compilable

    attr_reader :name

    def source_file_ending = "js"

    def build_file_ending = "js"

    def tile_type_name = "Js"

    def initialize(name)
      @name = name
    end

    def build
      if exists?
        File.write build_path, File.read(source_path)
      end
    end
  end
end
