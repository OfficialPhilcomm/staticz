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

    option :environment do
      desc "Set the environment"
      short "-e"
      long "--environment environment"

      default :production
      permit [:development, :production]
      convert :symbol
    end

    def run
      if params[:help]
        print help
        exit
      end

      if !params[:environment]
        puts "Environment must either be development or production"
        exit 1
      end

      Staticz::Settings.set_environment(params[:environment])
      Staticz::Builder.new
    end
  end
end
