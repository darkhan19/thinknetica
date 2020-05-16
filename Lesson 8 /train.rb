# frozen_string_literal: true

class Train
  include InstanceCounter
  include Company
  attr_reader :number, :wagons, :current_station, :current_route, :speed

  REGEXP = /^[a-z]{3}[0-9]{2}$/i.freeze

  @@trains_list = {}

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
    @@trains_list[number] = self
    register_instance
  end

  def self.find(number)
    @@trains_list[number]
  end

  def wagons_each
    @wagons.each { |wagon| yield(wagon) }
  end

  def del_wagon(index)
    wagons.delete_at(index)
  end

  def passanger?
    is_a? PassangerTrain
  end

  def cargo?
    is_a? CargoTrain
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def set_route(route)
    @current_route = route
    @current_station = route.stations[0]
    @current_station.add_train(self)
  end

  def next_station
    count = @current_route.stations.index(@current_station) + 1
    @current_station.send_train(self)
    @current_station = @current_route.stations[count]
    @current_station.add_train(self)
  end

  def previous_station
    count = @current_route.stations.index(@current_station) - 1
    @current_station.send_train(self)
    @current_station = @current_route.stations[count]
    @current_station.add_train(self)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def first_station?
    @current_station == @current_route.stations.first
  end

  def last_station?
    @current_station == @current_route.stations.last
  end

  protected

  def validate!
    raise 'Неверный формат!' if number !~ REGEXP
  end
end
