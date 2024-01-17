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

function temperature(vec::X, sensor::Sensor) where {X <: AbstractVector}
    map(T -> temperature(T, sensor), vec)
end

@doc """
    temperature(resistance::X, sensor::ITS90PT100) where {X}

Function used to calculate the temperature of a **Resistance Temperature Device (RTD)** based on the ITS-90 PT standard. The interpolation equation was developed for the ITS-90 temperature definition and is defined by parts based on the temperature reference adopted. The temperature function applies only the deviation formula given by:

```math
W-Wr=a_5\\left(W-1\\right)+b_5\\left(W-1\\right)^2
```
or
```math
W-Wr=a_{10}\\left(W-1\\right)
```

The first equation is used when the `resistance` provided is smaller than the value of `sensor.ITS90_transition_resistance`, which is the value of the resistance of the RTD at 273.15K.

The value of `W` is defined by:

```math
W = \\frac{`resistance`}{sensor.RTPW}
```

The variable `Wr` is computed from the general interpolators defined in `ITS90ScalePTctes`, one interpolator is defined for higher temepratures and another for lower termperatures.

See [ITS-90](https://www.nist.gov/system/files/documents/pml/div685/grp01/ITS-90_metrologia.pdf) paper for further reference.

# Arguments

- `resistence`: The value of the resistance measured in the RTD in ohms.
- `sensor::ITS90PT100`: The sensor used to measure temperature. Calibration with the parameters from the ITS-90 equations are required.


# Example
```jldoctest
julia> sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)
ITS90PT100(-0.020386711, 0.0033068936, -0.019700442, 100.0121, 100.01209954383037)

julia> temperature(sensor.ITS90_transition_resistance, sensor)
273.1599988338994
```
"""
function temperature(resistance::X, sensor::ITS90PT100) where {X <: AbstractFloat}
    scale = ITS90ScalePTctes()
    if resistance ≥ sensor.ITS90_transition_resistance
        a10 = sensor.a10
        RTPW = sensor.RTPW
        W = resistance / RTPW
        Wr = W * (1 - a10) + a10

        x = (Wr - 2.64) / 1.64

        T = scale.temperature_high(x) + 273.15
        return X(T)
    elseif resistance ≥ 0.0
        a5 = sensor.a5
        b5 = sensor.b5
        RTPW = sensor.RTPW
        W = resistance / RTPW
        Wr = W - a5 * (W - 1) - b5 * (W - 1)^2

        x = (Wr^(1 / 6) - 0.65) / 0.35

        T = scale.temperature_low(x) * 273.16

        return X(T)
    else
        @error "Negative resistance is not valid!"
        throw(OutOfRangeError())
        return X(-1)
    end
end

function temperature(resistance::X, sensor::ITS90PT100) where {X <: Real}
    res = AbstractFloat(resistance)
    return temperature(res, sensor)
end
