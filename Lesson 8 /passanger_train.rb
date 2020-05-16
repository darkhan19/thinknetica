# frozen_string_literal: true

class PassangerTrain < Train
  attr_reader :number
  attr_accessor :wagons, :current_route, :current_station, :type

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
    @type = 'Пассажирский'
  end
end
