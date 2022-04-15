def render(component)
  engine = ::Haml::Engine.new(File.read("src/#{component}.haml"))
  engine.render
end

def link(path, text)
  ::Haml::Engine.new("%a{href:\"#{path}\"} #{text}").render
end
