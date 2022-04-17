# frozen_string_literal: true

require 'pry'

module TimeCalculation
  class << self
    def listen(argv)
      unit, ele1, op, ele2 = argv
      val1, unit1 = ele1.split(/([y | d | h | m | s])/)
      val2, unit2 = ele2.split(/([y | d | h | m | s])/)
      time1 = Timee.new(value: val1, unit: unit1)
      time2 = Timee.new(value: val2, unit: unit2)
      result = time1 + time2
      result.class.new(value: result.convert_value(unit), unit: unit)
    end
  end
end

class Timee
  attr_reader :value, :unit

  def initialize(value:, unit:)
    @value = value.to_f
    @unit = unit
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
