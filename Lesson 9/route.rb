# frozen_string_literal: true
require_relative './modules/accessor.rb'
require_relative './modules/instance_counter.rb'
require_relative './modules/validation.rb'

class Route
  include InstanceCounter, Accessor, Validation
  attr_reader :name, :from, :to
  attr_accessor :stations

  REGEXP = /[a-z]/i.freeze
  validate :from, :format, REGEXP
  validate :to, :format, REGEXP
  validate :name, :format, REGEXP

  def initialize(from, to, name)
    @stations = [from, to]
    @name = name
    register_instance
    validate!
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
end
