module TemperatureSensors


import Polynomials


# Write your package code here.

include("ErrorTypes.jl")

include("Sensors.jl")
include("ITS90.jl")
include("ResistancesITS90PT.jl")
include("TemperatureCalculation.jl")

export ITS90ScalePTctes
export temperature
export resistance
export RTD, PT100, Thermocouple, ThermocoupleJ, Sensor, ITS90PT100

end
