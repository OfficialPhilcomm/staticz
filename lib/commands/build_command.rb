require "tty-option"
require_relative "../settings"
require_relative "../builder"

module Staticz
  class BuildCommand
    include TTY::Option

    usage do
      program "staticz"
      command "build"

      description "Compile the project"
    end

    flag :help do
      short "-h"
      long "--help"
      desc "Print this page"
    end

    def run
      if params[:help]
        print help
      else
        Staticz::Settings.production!
        Staticz::Builder.new
      end
    end
  end
end
