class CargoTrain < Train
  attr_reader :number
  attr_accessor :wagons

  def initialize(number)
    @number = number
    @wagons = []
  end
end
