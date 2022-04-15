def render(component)
  engine = ::Haml::Engine.new(File.read("src/#{component}.haml"))
  engine.render
end

def link(path, text: nil, &block)
  if block
    content = capture_haml(&block)
    "<a href=\"#{path}\">#{content}</a>"
  else
    "<a href=\"#{path}\">#{text}</a>"
  end
end
