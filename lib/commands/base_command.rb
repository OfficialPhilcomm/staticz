require "tty-option"

module Staticz
  class BaseCommand
    include TTY::Option

    usage do
      program "staticz"
      no_command

      description "Staticz helps create static websites",
        "\nCommands:",
        "  staticz new - Create a new project",
        "  staticz server - Run the development server",
        "  staticz manifest - Print out all files and how they will be built",
        "  staticz build - Compile the project"
    end

    argument :mode do
      desc "[new server manifest build]"
    end

    flag :help do
      short "-h"
      long "--help"
      desc "Print this page"
    end

    flag :version do
      short "-v"
      long "--version"
      desc "Print the version"
    end

    def run
      if params[:version]
        puts Staticz::VERSION
      else
        puts help
      end
    end
  end
end
