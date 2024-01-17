
@safetestset "ITS 90 temperature from ressitance" begin
    using TemperatureSensors
    sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)

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
    ]

    native_call = temperature(Rs, sensor)
    single_call = [temperature(r, sensor) for r in Rs]

    @test native_call == single_call
end
