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

    function (a5, b5, a10, RTPW)
        new(a5, b5, a10, RTPW)
    end
end
