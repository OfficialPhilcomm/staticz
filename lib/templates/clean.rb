require_relative "template"

module Staticz::Templates
  class Clean
    extend Staticz::Template

    folders "src"

    file "manifest.rb", <<~RUBY
      Staticz::Manifest.define do
      end
    RUBY
  end
end
