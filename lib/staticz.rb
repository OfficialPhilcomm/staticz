require "tty-option"
require_relative "commands/base_command"
require_relative "commands/new_command"
require_relative "commands/server_command"
require_relative "commands/manifest_command"
require_relative "commands/build_command"

module Staticz
  VERSION = "1.1.1"

  def self.init
    cmd, args = case ARGV[0]
    when "new"
      [Staticz::NewCommand.new, ARGV[1..]]
    when "server"
      [Staticz::ServerCommand.new, ARGV[1..]]
    when "manifest"
      [Staticz::ManifestCommand.new, ARGV[1..]]
    when "build"
      [Staticz::BuildCommand.new, ARGV[1..]]
    else
      [Staticz::BaseCommand.new, ARGV]
    end

    cmd.parse args
    cmd.run
  end
end
