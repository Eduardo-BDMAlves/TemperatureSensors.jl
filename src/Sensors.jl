abstract type Sensor end

abstract type RTD <: Sensor end

abstract type Thermoresistor <: Sensor end

abstract type Thermocouple <: Sensor end

struct ThermocoupleJ <: Thermocouple end

struct PT100 <: RTD
end

struct ITS90PT100 <: RTD
    a5::Real
    b5::Real

    a10::Real

    RTPW::Real

    ITS90_transition_resistance::Real

    function ITS90PT100(a5, b5, a10, RTPW)
        params = (a5 = a5, b5 = b5, a10 = a10, RTPW = RTPW)

        transition_resistance = resistance(273.16, params)

        new(a5, b5, a10, RTPW, transition_resistance)
    end
end
