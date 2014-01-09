class ApplicationSerializer < ActiveModel::Serializer

  fail '#options already exists, remove this hack!' if method_defined?(:options)
  attr_reader :options

  def self.links(&block)
    @links_block = block if block_given?
    @links_block || Proc.new {}
  end

  def initialize(object, options={})
    @options = options
    super
  end

  def link(rel, opts = {})
    links[rel] = opts[:href]
  end

  def filter(keys)
    keys = super(keys)
    self.instance_eval(&self.class.links)
    keys << :links unless links.empty?
    keys
  end

  private

  def links
    @links ||= {}
  end
end
