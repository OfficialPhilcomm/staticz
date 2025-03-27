require_relative "template"

module Staticz::Templates
  class Simple
    extend Staticz::Template

    folders "src", "src/css", "src/img"

    file "manifest.rb", <<~RUBY
      Staticz::Manifest.define do
        haml :index

        sub :css do
          sass :main
        end
      end
    RUBY

    file "src/index.haml", <<~HAML
      <!DOCTYPE html>
      %html(lang="en")
        %head
          %meta(charset="UTF-8")
          %meta(name="viewport" content="width=device-width, initial-scale=1")

          %meta(name="description" content="Site description")
          %meta(name="keywords" content="website, staticz")

          %meta(property="og:site_name" content="example.com")
          %meta(property="og:title" content="Site created with staticz")
          %meta(property="og:description" content="Site description")
          %meta(property="og:type" content="website")
          %meta(property="og:url" content="https://example.com/")
          %meta(property="og:title" content="App created with staticz")

          %title App created with staticz

          = stylesheet css_main_path

          = reload_js

        %body
          Hello World!
    HAML

    file "src/css/main.sass", <<~SASS
      html,body
        padding: 0
        margin: 0
    SASS
  end
end
