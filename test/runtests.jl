using TemperatureSensors
using Test
using Aqua
using JET

@testset "TemperatureSensors.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(TemperatureSensors)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(TemperatureSensors; target_defined_modules = true)
    end
    # Write your tests here.
end
