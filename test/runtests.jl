using TemperatureSensors
using Test
using SafeTestsets
using Aqua
using JET

@safetestset "TemperatureSensors.jl" begin
    @safetestset "Code quality (Aqua.jl)" begin
        using TemperatureSensors
        using Aqua
        Aqua.test_all(TemperatureSensors,
            # stale_deps = (ignore=[:Unitful],),
            piracies = true)
    end
    @safetestset "Code linting (JET.jl)" begin
        using TemperatureSensors
        using JET
        JET.test_package(TemperatureSensors; target_defined_modules = true)
    end
    # Write your tests here.

    @safetestset "Simple error test" begin
        using TemperatureSensors
        thermoJ = TemperatureSensors.ThermocoupleJ()

        try
            temp = temperature(100.0, thermoJ)
        catch e
            @test e == TemperatureSensors.NotImplementerError()
        end
    end

    @safetestset "ITS90 RTD tests" begin
        include("ITS90ScaleTests.jl")
    end

    @safetestset "Vector Inputs" begin
        include("VectorInputs.jl")
    end
end
