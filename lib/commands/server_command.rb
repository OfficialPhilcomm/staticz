require "tty-option"
require_relative "../settings"
require_relative "../server"

module Staticz
  class ServerCommand
    include TTY::Option

    usage do
      program "staticz"
      command "server"

      description "Run the development server"
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
        Staticz::Settings.development!
        Staticz::Server.new
      end
    end
  end
end
