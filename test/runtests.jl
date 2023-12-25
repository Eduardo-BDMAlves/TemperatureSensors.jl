using TemperatureSensors
using Test
using SafeTestsets
using Aqua
using JET

@safetestset "TemperatureSensors.jl" begin
    @safetestset "Code quality (Aqua.jl)" begin
        using TemperatureSensors
        using Aqua
        Aqua.test_all(TemperatureSensors)
    end
    @safetestset "Code linting (JET.jl)" begin
        using TemperatureSensors
        using JET
        JET.test_package(TemperatureSensors; target_defined_modules = true)
    end
    # Write your tests here.
end
