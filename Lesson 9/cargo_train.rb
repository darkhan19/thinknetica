# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :number
  attr_accessor :wagons, :current_route, :current_station, :type

  REGEXP = /^[a-z]{3}[0-9]{2}$/i.freeze
  validate :number, :format, REGEXP

  def initialize(number)
    @number = number
    @wagons = []
    @current_route = []
    @current_station = []
    @type = 'Грузовой'
    validate!
  end
end
