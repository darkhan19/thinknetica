# frozen_string_literal: true

class PassangerWagon < Wagon
  attr_accessor :size, :used
  attr_reader :number, :type
  validate :size, :type, Integer

  def initialize(size)
    @number = rand(1..1000)
    @size = size
    @type = 'Пассажирский'
    @used = 0
    validate!
  end
end
