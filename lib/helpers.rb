def render(component, &block)
  engine = ::Haml::Engine.new(File.read("src/#{component}.haml"))

  if block
    engine.render({}, &block)
  else
    engine.render
  end
end

def link(path, text: nil, &block)
  if block
    content = capture_haml(&block)
    "<a href=\"#{path}\">#{content}</a>"
  else
    "<a href=\"#{path}\">#{text}</a>"
  end
end

def stylesheet(path)
  "<link href=\"#{path}\" rel=\"stylesheet\">"
end

def javascript(path)
  "<script src=\"#{path}\"></script>"
end
