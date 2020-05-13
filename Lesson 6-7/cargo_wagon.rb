class CargoWagon < Wagon
  attr_accessor :size, :used_size
  attr_reader :number, :type

  def initialize(size)
    @size = size
    @number = rand(1..1000) 
    @used_size = 0
    @type = "Грузовой"
  end

  def free_space
    @size - @used_size
  end

  def add_size(n)
    raise 'Места нет!' if free_space == 0
    raise 'Столько места нет!' if free_space < n
    @used_size += n
  end
end

