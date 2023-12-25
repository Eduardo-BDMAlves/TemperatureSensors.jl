abstract type Sensor end

abstract type RTD <: Sensor end

abstract type Thermoresistor <: Sensor end

abstract type Thermocouple <: Sensor end

struct ThermocoupleJ <: Thermocouple end

struct PT100 <: RTD
end

struct ITS90PT100 <: RTD
    a10::Real
    RTPW::Real

    function (RTPW, a10)
        new(a10,
            RTPW)
    end
end
