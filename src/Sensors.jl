abstract type Sensor end

abstract type RTD <: Sensor end

abstract type Thermoresistor <: Sensor end

abstract type Thermocouple <: Sensor end

struct ThermocoupleJ <: Thermocouple end

struct PT100 <: RTD
end
