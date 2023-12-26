
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

    @debug "Resistences computed = $resistences_computed"

    @testset "Resistance from temperature" begin
        [@test isapprox(r_certificate, r_computed, atol = 0.03)
         for (r_certificate, r_computed) in zip(certificate_values.Rs, resistences_computed)]
    end
end
