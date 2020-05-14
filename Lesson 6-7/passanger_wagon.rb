class PassangerWagon < Wagon
  attr_accessor :size, :used
  attr_reader :number, :type

  def initialize(size)
    @number = rand(1..1000) 
    @size = size
    @type = "Пассажирский"
    @used = 0
  end
end
