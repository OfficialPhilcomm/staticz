module Statics
  class Template
    def initialize(name)
      src = File.join(File.dirname(__FILE__), "template")

      FileUtils.copy_entry src, File.join(Dir.pwd, name)
    end
  end
end
