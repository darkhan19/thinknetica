class Wagon
  include Company, InstanceCounter
  attr_accessor :size, :used
  attr_reader :number 

  def initialize(size)
    @size = size
    @number = rand(1..1000)
    @used = 0
  end 
  
  def cargo?
    self.class == CargoWagon 
  end

  def passanger?
    self.class == PassangerWagon 
  end
end

