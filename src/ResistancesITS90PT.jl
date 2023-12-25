## Defines the resistance calculation using ITS-90 relations for PT sensors

function relative_resistance(temperature::T, ctes::ITS90ScalePTctes) where {T}
    s = T(0)
    if (temperature < 273.16) && (temperature > 13.8033)
        lnT = log(temperature / 273.16)
        x = (lnT + 1.5) / 1.5
        s = ctes.resistance_low(x)
        # for (i,A) in enumerate(ctes.A[2:end])
        #     s += A*x^i
        # end
        return exp(s)
    elseif temperature < 961.68 + 273.15
        x = (temperature - 754.15) / 481
        # for (i,C) in enumerate(ctes.C[2:end])
        #     s += C*x^i
        # end
        s = ctes.resistance_high(x)
        return s

    else
        throw(OutOfRangeError())
        return T(-1)
    end
end

function resistance(temperature::T, params, ctes::ITS90ScalePTctes) where {T}
    Wr = relative_resistance(temperature, ctes)
    if 234.3156 ≤ temperature ≤ 302.9146
        a5 = params.a5
        b5 = params.b5
        gamma0 = (a5 - 2b5 - 1) / b5
        gamma1 = (Wr - a5 + b5) / b5
        W = 0.5 * (-gamma0 - sqrt(gamma0 * gamma0 - 4gamma1))
        return W * params.RTPW
    elseif temperature > 300
        a10 = params.a10
        W = (Wr - a10) / (1 - a10)
        return W * params.RTPW
    else
        throw(NotImplementerError())
        return T(-1)
    end
end

resistance(temperature, params) = resistance(temperature, params, ITS90ScalePTctes())
