require "tty-option"
require_relative "../templates/clean"
require_relative "../templates/simple"
require_relative "../templates/layout"

module Staticz
  class NewCommand
    include TTY::Option

    usage do
      program "staticz"
      command "staticz"

      description "Create a new project"
    end

    argument :name do
      required
      desc "The name to give the app. Decides how the folder is named"
    end

    option :template do
      short "-t"
      long "--template name"
      desc "The template to use"

      default "clean"
      permit %w[clean simple layout]
    end

    flag :with_gitignore do
      long "--with-gitignore"
      desc "Add basic .gitignore file"
    end

    flag :help do
      short "-h"
      long "--help"
      desc "Print this page"
    end

    def run
      if params[:help]
        print help
        exit 1
      end

      if params.errors.any?
        puts params.errors.summary
        exit 1
      end

      Object
        .const_get("Staticz::Templates::#{params[:template].capitalize}")
        .tap do |template|
          if params[:with_gitignore]
            template.file ".gitignore", <<~GITIGNORE
              build/
            GITIGNORE
          end
        end
        .build(params[:name])
    end
  end
end
