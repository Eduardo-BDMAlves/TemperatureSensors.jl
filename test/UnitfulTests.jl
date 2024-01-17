@safetestset "Temperature Conversions" begin
    using TemperatureSensors
    using Unitful

    sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)

    transition_temperature = temperature(sensor.ITS90_transition_resistance, sensor)u"K" |>
                             u"°C"

    transition_resistance = resistance(transition_temperature, sensor, u"kΩ")

    transition_resistance_kΩ_striped = ustrip(transition_resistance)

    transition_temperature = temperature(transition_resistance, sensor)
    transition_resistance_from_temp = resistance(transition_temperature, sensor)

    @test transition_resistance ≈ transition_resistance_from_temp

    @test transition_resistance_kΩ_striped ≈ sensor.ITS90_transition_resistance / 1000

    Rs = [100u"Ω", 0.101u"kΩ", 110u"Ω"]

    Ts = temperature(Rs, sensor)
    Rs_from_Ts = resistance(Ts, sensor)

    @test Rs ≈ Rs_from_Ts
end
