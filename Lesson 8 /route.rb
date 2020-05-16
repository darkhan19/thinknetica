# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :name
  attr_accessor :stations

  REGEXP = /[a-z]/i.freeze

  def initialize(from, to, name)
    @stations = [from, to]
    @name = name
    validate!
    register_instance
  end

  def add_midway(name)
    raise 'Такая станция уже есть в маршруте!' if @stations.include?(name)

    @stations.insert(-2, name)
  end

  def last?
    stations == stations.last
  end

  def first?
    stations == stations.first
  end

  def del_route(name)
    @stations.delete(name)
  end

  def del_station(index)
    if stations[index] == stations.first
      raise 'Нельзя удалить начальную станцию'
    end
    raise 'Нельзя удалить конечную станцию' if stations[index] == stations.last

    @routes[route].stations.delete_at(station)
  end

  protected

  def validate!
    raise 'Неверный формат! Только латинские буквы!' if name !~ REGEXP
  end
end
