require "tty-option"
require_relative "../template"

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

    def run
      if params[:help]
        print help
        exit 1
      end

      if !params[:name]
        puts "Name missing"
        print help
        exit 1
      end

      Staticz::Template.new(params[:name])
    end
  end
end
