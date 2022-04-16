Gem::Specification.new do |s|
  s.name = 'statics'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Static website compiler'
  s.description = "Create websites with haml and sass, and compile them into static html and css"
  s.authors = ['Philipp Schlesinger']
  s.email = ['info@philcomm.dev']
  s.homepage = 'http://rubygems.org/gems/statics'
  s.license = 'MIT'
  s.files = Dir.glob('{lib,bin}/**/*')
  s.require_path = 'lib'
  s.executables = ['statics']

  s.add_dependency "haml", ["~> 5.2"]
  s.add_dependency "rspec", ["~> 3.11"]
  s.add_dependency "thin", ["~> 1.8"]
  s.add_dependency "listen", ["~> 3.7"]
  s.add_dependency "sassc", ["~> 2.4"]
  s.add_dependency "coffee-script", ["~> 2.4"]
end
