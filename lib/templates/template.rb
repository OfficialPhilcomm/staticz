require_relative "template"

module Staticz::Template
  def folders(*folders)
    @folders = folders
  end

  def file(path, content)
    @files = @files || []
    @files << [path, content]
  end

  def build(destination)
    root_path = File.join(Dir.pwd, destination)

    Dir.mkdir(root_path) if !Dir.exist?(root_path)
    @folders.each do |folder|
      Dir.mkdir(File.join(root_path, folder)) if !Dir.exist?(File.join(root_path, folder))
    end

    @files.each do |path, content|
      File.write(File.join(root_path, path), content)
    end
  end
end
