module MeasurementsUnitfulExt

using Unitful
using Measurements
using TemperatureSensors

# using Unitful: Ω, K

function TemperatureSensors.temperature(param::X,
        sensor::ITS90PT100,
        out_unit = u"K") where {X <: Quantity{Measurement{Float64}}}
    param_SI = uconvert(u"Ω", param)
    param_striped = ustrip(param_SI)

    T = temperature_uncertainty(param_striped, sensor)

    T_unit = T * u"K"
    return uconvert(out_unit, T_unit)
end

end
