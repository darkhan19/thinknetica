# frozen_string_literal: true

module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      raise 'Аргумент не является символом' unless name.is_a?(Symbol)

      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method "#{name}_history" do
        instance_variable_get("@#{name}_history")
      end

      define_method("#{name}=") do |new_value|
        value = instance_variable_get("@#{name}_history")
        value ||= []
        value << new_value
        instance_variable_set("@#{name}_history", value)
        instance_variable_set(var_name, new_value)
      end
    end
  end
end

module StrongAttrAccessor
  def strong_attr_accessor(name, class_name)
    raise 'Аргумент не является символом' unless name.is_a?(Symbol)
    raise 'Аргумент не является классом' unless class_name.is_a?(Class)

    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise 'Класс  не совпадает' unless value.is_a?(class_name)

      instance_variable_set("@#{name}", value)
    end
  end
end
