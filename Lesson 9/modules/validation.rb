# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates
    def validate(name, *args)
      @validates ||= []
      @validates << { name => args }
     end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |val|
        val.each do |name, args|
          name = instance_variable_get("@#{name}")
          send("validate_#{args[0]}".to_sym, name, *args[1])
        end
      end
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

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
