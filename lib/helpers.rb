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

def react(*component_file_paths)
  lines = [
    "<script crossorigin src=\"https://unpkg.com/react@18/umd/react.development.js\"></script>",
    "<script crossorigin src=\"https://unpkg.com/react-dom@18/umd/react-dom.development.js\"></script>",
    component_file_paths.map do |component_file_path|
      javascript(component_file_path)
    end
  ].flatten.join("\n")
end

def react_mount(*components)
  components.map do |component|
    [
      "<script>",
      "document.querySelectorAll('[data-component=\"#{component}\"]')",
      ".forEach(domContainer => {",
      "console.log('yas')",
      "const root = ReactDOM.createRoot(domContainer);",
      "root.render(React.createElement(#{component}));",
      "});",
      "</script>"
    ]
  end.flatten.join("\n")
end

def react_component(name, css_class = nil)
  "<div data-component=\"#{name}\" class=\"#{css_class}\"></div>"
end
