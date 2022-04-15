def render(component)
  engine = ::Haml::Engine.new(File.open("src/#{component}.haml").read)
  engine.render
end
