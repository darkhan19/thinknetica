# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates
    def validate(name, type, *arg)
      @validates ||= []
      @validates << { name: name, type: type, arg: arg }
     end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |val|
          name = instance_variable_get("@#{val[:name]}")
          send("validate_#{val[:type]}".to_sym, name, *val[:arg])
        end
      end
  end
  

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private
  
  def validate_presence(name)
    raise 'Название не может быть пустым' if name.nil? || name.strip.empty?
  end

  def validate_format(name, format)
    raise 'Ошибка формата' if name !~ format
  end

  def validate_type(name, format)
    raise 'Класс не совпадает' unless name.is_a?(format)
  end
end
