def render(component)
  engine = ::Haml::Engine.new(File.open("src/#{component}.haml").read)
  engine.render
end

def link(path, text)
  ::Haml::Engine.new("%a{href:\"#{path}\"} #{text}").render
end
