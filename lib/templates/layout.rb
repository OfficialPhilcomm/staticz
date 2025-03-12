require_relative "template"

module Staticz::Templates
  class Layout
    extend Staticz::Template

    folders "src", "src/css"

    file "manifest.rb", <<~RUBY
      Staticz::Manifest.define do
        haml :index

        sub :css do
          sass :main
        end
      end
    RUBY

    file "src/index.haml", <<~HAML
      = render :template do
        %main
          Hello World!
     HAML

    file "src/template.haml", <<~HAML
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
          = render :nav
          = capture_haml(&block)
          = render :footer
    HAML

    file "src/nav.haml", <<~HAML
      %nav navigation
    HAML

    file "src/footer.haml", <<~HAML
      %footer footer
    HAML

    file "src/css/main.sass", <<~SASS
      html,body
        padding: 0
        margin: 0
    SASS

    file ".gitignore", <<~GITIGNORE
      build/
    GITIGNORE
  end
end
