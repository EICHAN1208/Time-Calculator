# frozen_string_literal: true

require 'pry'

module TimeCalculation
  class << self
    def listen(argv)
      unit, ele1, op, ele2 = argv
      Timee.calculate(
        items: [ele1, ele2],
        unit: unit,
        operator: op
      )
    end
  end
end

class Timee
  attr_reader :value, :unit

  def initialize(value:, unit:)
    @value = value.to_f
    @unit = unit
  end

  class << self
    def calculate(items:, unit:, operator:)
      time1, time2 = Timee.build_all(items[0], items[1])
      result = time1.send(operator, time2)
      new(value: result.convert_value(unit), unit: unit)
    end

    def build_all(element1, element2)
      [element1, element2].map { |e| new(attributes(e)) }
    end

    def attributes(element)
      value, unit = element.split(/([y | d | h | m | s])/)
      { value: value, unit: unit }
    end
  end

  def inspect
    "#{@value}#{@unit}"
  end

  def convert(new_unit)
    new_value = convert_value(new_unit)
    self.class.new(value: new_value, unit: new_unit)
  end

  def convert_value(new_unit)
    value * (Unit.new(name: unit).ratio / Unit.new(name: new_unit).ratio.to_f)
  end

  def +(other)
    new_value = @value + other.convert(@unit).value
    self.class.new(value: new_value, unit: @unit)
  end

  def -(other)
    new_value = @value - other.convert(@unit).value
    self.class.new(value: new_value, unit: @unit)
  end
end

class Unit
  attr_reader :name, :ratio

  CONVERSION_TABLE = {
    y: 60 * 60 * 24 * 365, # year
    d: 60 * 60 * 24, # day
    h: 60 * 60, # hour
    m: 60, # minute
    s: 1 # second
  }.freeze

  def initialize(name:)
    @name = name
    @ratio = CONVERSION_TABLE[name.to_sym]
  end
end
