require 'active_support'

module SymbolSerializer
  extend ActiveSupport::Concern

  included do
    before_enqueue :serialize_symbol_in_arguments
    before_perform :deserialize_symbol_in_arguments

    def serialize_symbol_in_arguments
      self.arguments.each_with_index do |element, index|
        self.arguments[index] = element_serializer(element)
      end
    end

    def deserialize_symbol_in_arguments
      self.arguments.each_with_index do |element, index|
        self.arguments[index] = element_deserializer(element)
      end
    end

    def element_serializer(element)
      return nil if element.nil?
      if element.instance_of? Symbol
        element = symbol_serializer(element)
      elsif element.is_a? Hash
        element.keys.each do |key|
          value = element[key]
          element[key] = element_serializer(value)
        end
      elsif element.is_a? Array
        element.each_with_index do |value, index|
          element[index] = element_serializer(value)
        end
      end
      element
    end

    def element_deserializer(element)
      return nil if element.nil?
      if is_a_serialized_symbol?(element)
        element = symbol_deserializer(element)
      elsif element.is_a? Hash
        element.keys.each do |key|
          value = element[key]
          element[key] = element_deserializer(value)
        end
      elsif element.is_a? Array
        element.each_with_index do |value, index|
          element[index] = element_deserializer(value)
        end
      end
      element
    end

    def symbol_serializer(symbol)
      return symbol unless symbol.class == Symbol
      {
          _serializing_datatype: Symbol.name,
          value: symbol.to_s
      }
    end

    def symbol_deserializer(serialized_symbol)
      return serialized_symbol unless is_a_serialized_symbol?(serialized_symbol)
      serialized_symbol[:value].to_s.to_sym
    end

    def is_a_serialized_symbol?(hash)
      hash.is_a?(Hash) &&
          hash[:_serializing_datatype].present? &&
          hash[:_serializing_datatype] == Symbol.name
    end
  end

end
