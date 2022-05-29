module Staticz
  module Modules
    class LibLoader
      def self.load_files
        return if !Dir.exist? "lib"

        Dir["lib/**/*.rb"].each do |rb_file|
          begin
            load rb_file
          rescue SyntaxError => e
            puts Colors.in_red("Could not load #{rb_file}:")
            puts Colors.in_red(e.message)
          end
        end
      end
    end
  end
end
