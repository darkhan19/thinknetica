# frozen_string_literal: true

class Wagon
  include InstanceCounter
  include Company
  attr_accessor :size, :used
  attr_reader :number

  def initialize(size)
    @size = size
    @number = rand(1..1000)
    @used = 0
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
