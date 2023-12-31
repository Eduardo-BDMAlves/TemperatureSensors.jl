@safetestset "ITS struct test" begin
    using TemperatureSensors
    sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)

    trans_temp = temperature(sensor.ITS90_transition_resistance, sensor)

    @test trans_temp ≈ 273.16
end

@safetestset "ITS temperature extrapolation error" begin
    using TemperatureSensors
    sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)

    @testset "High temperature" begin
        try
            res = resistance(1000, sensor)
        catch e
            @test e == TemperatureSensors.OutOfRangeError()
        end
    end
    @testset "Low temperature" begin
        try
            res = resistance(1, sensor)
        catch e
            @test e == TemperatureSensors.OutOfRangeError()
        end
    end
    @testset "Low resistante" begin
        try
            res = resistance(-1, sensor)
        catch e
            @test e == TemperatureSensors.OutOfRangeError()
        end
    end
end

@safetestset "RTD certificated - 1" begin
    using TemperatureSensors

    sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)

    certificate_values = (Ts = [
            -40,
            -35,
            -30,
            -20,
            -10,
            0,
            5,
            10,
            15,
            20,
            25,
            30,
            50,
            60,
            90,
            100,
            140,
            156,
        ] .+ 273.15,
        Rs = [
            84.2826,
            86.2528,
            88.2308,
            92.1677,
            96.0934,
            100.0082,
            101.9627,
            103.9142,
            105.8627,
            107.8082,
            109.7508, #25
            111.6904,
            119.4192,
            123.2659,
            134.7355,
            138.5352,
            153.6174,
            159.5983,
        ])

    resistences_computed = map(x -> resistance(x, sensor),
        certificate_values.Ts)
    temperatures_computed = map(x -> temperature(x, sensor),
        certificate_values.Rs)

    @debug "Resistences computed = $resistences_computed"

    @testset "Resistance from temperature" begin
        [@test isapprox(r_certificate, r_computed, atol = 0.03)
         for (r_certificate, r_computed) in zip(certificate_values.Rs, resistences_computed)]
    end
    @testset "Temperature from resistance" begin
        [@test isapprox(T_certificate, T_computed, atol = 0.03)
         for (T_certificate, T_computed) in zip(certificate_values.Ts,
            temperatures_computed)]
    end
end
