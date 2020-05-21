# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :number
  attr_accessor :wagons, :current_route, :current_station, :type

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
    @type = 'Грузовой'
  end
end
