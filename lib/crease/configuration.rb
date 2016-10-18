module Crease

  def self.configuration
    @config ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :digits, :integer

    def initialize(digits: 2, integer: false)
      @digits = digits
      @integer = integer
    end
  end
end
