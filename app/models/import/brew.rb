require 'sidekiq'

module Import
  class Brew
    include Sidekiq::Worker

    def self.import(args)
      perform_async(args)
    end

    def initialize(warehouse = Warehouse.new)
      @warehouse = warehouse
    end

    def perform(args)
      binding.remote_pry
      id = brew_id(args)
      Agent.new(@warehouse).import_brew(id)
    end

    private

    def brew_id(args)
      args['id'] || args[:id] || fail(:missing_brew_id)
    end

  end
end
