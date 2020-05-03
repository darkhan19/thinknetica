class CargoWagon < Wagon
  attr_accessor :count

  def initialize(count)
    @count = count
  end
end
  