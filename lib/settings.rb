module Staticz
  class Settings
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
