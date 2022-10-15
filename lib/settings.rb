module Staticz
  class Settings
    def self.set_environment(environment)
      @@env = environment
    end

    def self.development!
      @@env = :development
    end

    def self.development?
      @@env == :development
    end

    def self.production!
      @@env = :production
    end

    def self.production?
      @@env == :production
    end
  end
end

def development?
  Staticz::Settings.development?
end

def production?
  Staticz::Settings.production?
end
