# frozen_string_literal: true
require_relative './modules/accessor.rb'
require_relative './modules/company.rb'
require_relative './modules/instance_counter.rb'
require_relative './modules/validation.rb'

class Wagon
  include InstanceCounter, Company, Accessor, Validation
  attr_accessor :size, :used
  attr_reader :number
  validate :size, :type, Integer

  def initialize(size)
    @size = size
    @number = rand(1..1000)
    @used = 0
    validate!
  end

  def free_space
    @size - @used
  end

  def cargo?
    self.class == CargoWagon
  end

  def passanger?
    self.class == PassangerWagon
  end

  def add_size(number = 1)
    raise 'Места нет!' if free_space.zero?
    raise 'Столько места нет!' if free_space < number

    @used += number
  end
end
