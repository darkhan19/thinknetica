# frozen_string_literal: true

class CargoWagon < Wagon
  attr_accessor :size, :used
  attr_reader :number, :type

  def initialize(size)
    @size = size
    @number = rand(1..1000)
    @used = 0
    @type = 'Грузовой'
  end
end
