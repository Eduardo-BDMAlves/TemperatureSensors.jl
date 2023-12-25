module TemperatureSensors

# Write your package code here.

include("ErrorTypes.jl")

include("Sensors.jl")
include("TemperatureCalculation.jl")

export temperature
export RTD, PT100, Thermocouple, ThermocoupleJ, Sensor

end
