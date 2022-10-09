# frozen_string_literal: true

require 'forwardable'

module Entity
  attr_reader :source_model

  extend Forwardable

  def_delegators :@source_model, *%w[destroy errors model_name persisted? to_model to_param update]

  def initialize(source_model)
    raise ArgumentError unless source_model.respond_to?(:attributes)

    self.source_model = source_model
    self.fields = defined?(self.class::FIELDS) ? self.class::FIELDS : []
    self.relations = defined?(self.class::RELATIONS) ? self.class::RELATIONS : {}
    (fields + relations.keys).each do |field|
      self.class.attr_accessor field
    end
  end

  def load(with_relations: false)
    source_model.attributes.slice(*fields).each do |attribute, value|
      send("#{attribute}=", value)
    end
    if with_relations
      relations.each do |attribute, model|
        source_value = source_model.send(attribute)
        value =
          if source_value.is_a? ActiveRecord::Relation
            model.decorate_collection(source_value)
          elsif source_value
            model.load(source_value, with_relations: false)
          end
        send("#{attribute}=", value)
      end
    end
    self
  end

  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

  module ClassMethods
    def decorate_collection(collection, options = {})
      collection.map { |record| load(record, options) }
    end

    def load(record, options = { with_relations: true })
      new(record).load(options)
    end
  end

  private

  attr_accessor :fields, :relations
  attr_writer :source_model
end
