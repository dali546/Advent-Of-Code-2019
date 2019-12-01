module FuelRequired
  def calc_fuel
    (@mass.to_i / 3).floor - 2
  end
end

class SleighModule
  attr_reader :mass

  def initialize(mass)
    @mass = Mass.new(mass)
  end

  def calc_fuel
    mass_fuel = @mass.calc_fuel
    if ((mass_fuel / 3).floor - 2) >= 0
      mass_fuel + SleighModule.new(mass_fuel).calc_fuel
    else
      mass_fuel
    end
  end
end

class Mass 
  include FuelRequired
  def initialize(mass)
    @mass = mass
  end
end

def make_modules(masses)
  masses.map do |mass|
    SleighModule.new(mass)
  end
end

def load_file
  File.open('day-1/input.txt')
end

def read_file(file)
  file.readlines.map(&:chomp)
end

file = load_file
masses = read_file(file)
modules = make_modules(masses)
modules.reduce(0) do |acc, sleigh_module|
  p acc + sleigh_module.calc_fuel
end
