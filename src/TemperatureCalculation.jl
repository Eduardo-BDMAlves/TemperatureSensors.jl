## This file is responsible for calculating temperature from independant variable and sensor.

@doc """
    temperature(parameter::Real, sensor::Sensor)

Base function for generic type of sensor. This function trhows error as is the generic function which deals with

# Arguments
- `parameter::Real`: the value of the independant variable. If for resistive sensors the value of resistance in ohms with which to compute the temperature.
- `sensor::Sensor`: the sensor used to measure temperature, any subtype of `Sensor` is valid.

# Example

    julia> temperature(100.0,ThermocoupleJ())
    ERROR: TemperatureSensors.NotImplementerError()

# Output

- `nothing`: the general implementation is used when the sensor is not implemented so both an error is thown and `nothing` value is returned.

"""
function temperature(parameter::Real, sensor::Sensor)
    throw(NotImplementerError())
    return nothing
end

function temperature(resistance::Real, sensor::RTD)
    return 0.0
end
