## Defines the resistance calculation using ITS-90 relations for PT sensors

function relative_resistance(temperature::T, ctes::ITS90ScalePTctes) where {T}
    s = T(0)
    if (temperature < 273.16) && (temperature > 13.8033)
        lnT = log(temperature / 273.16)
        x = (lnT + 1.5) / 1.5
        s = ctes.resistance_low(x)
        return exp(s)
    elseif temperature < (157 + 273.15)
        x = (temperature - 754.15) / 481
        s = ctes.resistance_high(x)
        return s

    else
        @error "Temperature:$temperature "
        throw(OutOfRangeError())
        return T(-1)
    end
end

function resistance(temperature::T, params, ctes::ITS90ScalePTctes) where {T}
    Wr = relative_resistance(temperature, ctes)
    if 232.3156 ≤ temperature ≤ 273.16
        a5 = params.a5
        b5 = params.b5
        gamma0 = (a5 - 2b5 - 1) / b5
        gamma1 = (Wr - a5 + b5) / b5
        W = 0.5 * (-gamma0 - sqrt(gamma0 * gamma0 - 4gamma1))
        return W * params.RTPW
    elseif temperature > 273.15
        a10 = params.a10
        W = (Wr - a10) / (1 - a10)
        return W * params.RTPW
    else
        print("Temperature:", temperature)
        throw(OutOfRangeError())
        return T(-1)
    end
end

function resistance(temperature, params::NamedTuple)
    resistance(temperature, params, ITS90ScalePTctes())
end

function resistance(temperature::T, sensor::ITS90PT100) where {T <: AbstractFloat}
    ctes = ITS90ScalePTctes()
    Wr = relative_resistance(temperature, ctes)
    if 232.3156 ≤ temperature ≤ 273.16
        a5 = sensor.a5
        b5 = sensor.b5
        gamma0 = (a5 - 2b5 - 1) / b5
        gamma1 = (Wr - a5 + b5) / b5
        W = 0.5 * (-gamma0 - sqrt(gamma0 * gamma0 - 4gamma1))
        return W * sensor.RTPW
    elseif temperature > 273.15
        a10 = sensor.a10
        W = (Wr - a10) / (1 - a10)
        return W * sensor.RTPW
    else
        print("Temperature:", temperature)
        throw(OutOfRangeError())
        return T(-1)
    end
end

function resistance(temperature::T, sensor::ITS90PT100) where {T <: Real}
    temp = AbstractFloat(temperature)
    return resistance(temp, sensor)
end

function resistance(temperatures::T, sensor::ITS90PT100) where {T <: AbstractVector}
    return map(x -> resistance(x, sensor), temperatures)
end
