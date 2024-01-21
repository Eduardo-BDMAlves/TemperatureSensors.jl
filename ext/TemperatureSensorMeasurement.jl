module TemperatureSensorMeasurement

using TemperatureSensors
using Measurements

function TemperatureSensors.temperature_uncertainty(resistance::Measurement, sensor::Sensor)
    sensor_uncertainty = sensor.sensor_uncertainty

    T = temperature(resistance, sensor)

    T_value = T.val
    T_unc = T.err

    combined_unc = sqrt(sensor_uncertainty^2 + T_unc^2)

    return T_value ± combined_unc
end

function TemperatureSensors.temperature_uncertainty(resistances::X,
        sensor::ITS90PT100) where {X <: AbstractVector{Measurement{Float64}}}
    return map(x -> TemperatureSensors.temperature_uncertainty(x, sensor), resistances)
end

end
