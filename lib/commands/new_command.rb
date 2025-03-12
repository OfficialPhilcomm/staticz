require "tty-option"
require_relative "../templates/default"
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

    flag :help do
      short "-h"
      long "--help"
      desc "Print this page"
    end

    option :template do
      short "-t"
      long "--template name"
      desc "The template to use"

      default "default"
      permit %w[default layout]
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
        .build(params[:name])
    end
  end
end
