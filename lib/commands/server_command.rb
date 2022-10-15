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

    option :port do
      desc "Define the port used for the webserver"
      short "-p"
      long "--port port"

      default 3000
      convert :integer
    end

    option :environment do
      desc "Set the environment"
      short "-e"
      long "--environment environment"

      default :development
      permit [:development, :production]
      convert :symbol
    end

    def run
      if params[:help]
        print help
        exit
      end

      if !params[:port]
        puts "A given port must be an integer"
        exit 1
      end

      if !params[:environment]
        puts "Environment must either be development or production"
        exit 1
      end

      Staticz::Settings.set_environment(params[:environment])
      Staticz::Server.new(params[:port])
    end
  end
end
