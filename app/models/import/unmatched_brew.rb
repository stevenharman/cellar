require 'active_support/core_ext/hash/indifferent_access'
require_relative '../import'

module Import
  class UnmatchedBrew

    IMPORTABLE_ATTRIBUTES.each do |attr|
      define_method("#{attr}") do
        @source_attrs[attr.to_s]
      end
    end

    def initialize(source_attrs = {})
      @source_attrs = source_attrs.with_indifferent_access
    end

    def name
      brew
    end

    def medium_image
      'no-label.png'
    end
  end
end
