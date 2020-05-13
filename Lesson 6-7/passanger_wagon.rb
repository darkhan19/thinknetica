class PassangerWagon < Wagon
  attr_accessor :seats, :used_seats
  attr_reader :number, :type

  def initialize(seats)
    @seats = seats
    @number = rand(1..1000) 
    @used_seats = 0
    @type = "Пассажирский"
  end

  def free_seats
    @seats - @used_seats
  end

  def used_seats
    @used_seats
  end

  def add_passanger
  raise 'Мест нет!' if free_seats == 0
  @used_seats +=1
  end
end
