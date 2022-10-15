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

    def run
      print help
    end
  end
end
