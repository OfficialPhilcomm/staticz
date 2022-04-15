def render(component)
  engine = Haml::Engine.new(File.open("#{component}.haml").read)
  engine.render
end
