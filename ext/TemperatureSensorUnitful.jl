module TemperatureSensorUnitful

using TemperatureSensors
using Unitful

function TemperatureSensors.temperature(param::X,
        sensor::Sensor,
        out_unit = u"K") where {X <: Unitful.ElectricalResistance}
    param_SI = uconvert(u"Ω", param)
    param_striped = ustrip(param_SI)

    val = TemperatureSensors.temperature(param_striped, sensor)
    val_unit = val * u"K"
    return uconvert(out_unit, val_unit)
end

function TemperatureSensors.temperature(params::X,
        sensor::Sensor,
        out_unit = u"K") where {X <: AbstractVector{Unitful.ElectricalResistance}}
    return map(x -> TemperatureSensors.temperature(x, sensor, out_unit), params)
end

function TemperatureSensors.resistance(param::X,
        sensor::Sensor,
        out_unit = u"Ω") where {X <: Unitful.Temperature}
    param_SI = uconvert(u"K", param)
    param_striped = ustrip(param_SI)

    val = TemperatureSensors.resistance(param_striped, sensor)
    val_unit = val * u"Ω"
    return uconvert(out_unit, val_unit)
end

function TemperatureSensors.resistance(params::X,
        sensor::Sensor,
        out_unit = u"Ω") where {X <: AbstractVector{Unitful.Temperature}}
    return map(x -> TemperatureSensors.resistance(x, sensor, out_unit), params)
end

end
