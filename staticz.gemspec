Gem::Specification.new do |s|
  s.name = 'staticz'
  s.version = '1.1.5'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = ">= 3.1.0"
  s.summary = 'Static website compiler'
  s.description = "Create websites with haml and sass, and compile them into static html and css"
  s.authors = ['Philipp Schlesinger']
  s.email = ['info@philcomm.dev']
  s.homepage = 'http://rubygems.org/gems/staticz'
  s.license = 'MIT'
  s.files = Dir.glob('{lib,bin}/**/*')
  s.require_path = 'lib'
  s.executables = ['staticz']

  s.metadata = {
    "documentation_uri" => "https://github.com/OfficialPhilcomm/staticz",
    "source_code_uri"   => "https://github.com/OfficialPhilcomm/staticz",
    "changelog_uri"     => "https://github.com/OfficialPhilcomm/staticz/blob/master/changelog.md"
  }

  s.add_dependency "haml", ["~> 5.2"]
  s.add_dependency "rspec", ["~> 3.11"]
  s.add_dependency "rack", ["2.2.10"]
  s.add_dependency "thin", ["1.8.2"]
  s.add_dependency "listen", ["~> 3.7"]
  s.add_dependency "sass-embedded", ["~> 1.83"]
  s.add_dependency "coffee-script", ["~> 2.4"]
  s.add_dependency "babel-transpiler", ["~> 0.7"]
  s.add_dependency "tty-option", ["~> 0.2"]
  s.add_dependency "tty-spinner", ["0.9"]
  s.add_dependency "pastel", ["~> 0.8.0"]
  s.add_dependency "slim", ["~> 5.2"]
end
