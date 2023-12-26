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
function temperature(parameter, sensor::Sensor)
    throw(NotImplementerError())
    return nothing
end

function temperature(resistance::X, sensor::ITS90PT100) where {X}
    scale = ITS90ScalePTctes()
    if resistance ≥ sensor.ITS90_transition_resistance
        a10 = sensor.a10
        RTPW = sensor.RTPW
        W = resistance/RTPW
        Wr = W*(1-a10)+a10

        x = (Wr-2.64)/1.64

        T = scale.temperature_high(x) + 273.15
        return X(T)
    elseif resistance ≥ 0.0
        a5=sensor.a5
        b5=sensor.b5
        RTPW=sensor.RTPW
        W = resistance/RTPW
        Wr = W-a5*(W-1)-b5*(W-1)^2

        x = (Wr^(1/6)-0.65)/0.35

        T = scale.temperature_low(x)*273.16

        return X(T)
    else
        @error "Negative resistance is not valid!"
        throw(OutOfRangeError())
        return X(-1)
    end
end
