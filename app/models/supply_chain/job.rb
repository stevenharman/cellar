module SupplyChain
  module Job

    def self.included(base)
      directory << base
    end

    def self.directory
      @__directory__ ||= []
    end

  end
end
