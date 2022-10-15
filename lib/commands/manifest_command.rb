require "tty-option"
require_relative "../settings"
require_relative "../modules/lib_loader"
require_relative "../manifest/manifest"

module Staticz
  class ManifestCommand
    include TTY::Option

    usage do
      program "staticz"
      command "manifest"

      description "Print out all files and how they will be built"
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

        load "#{Dir.pwd}/manifest.rb"
        Staticz::Modules::LibLoader.load_files
        Staticz::Manifest.instance.create_link_functions

        Staticz::Manifest.instance.print
      end
    end
  end
end
