class CargoTrain < Train
  attr_reader :number
  attr_accessor :wagons, :current_route, :current_station

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
  end
end
