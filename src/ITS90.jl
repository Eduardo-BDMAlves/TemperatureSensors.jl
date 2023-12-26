
struct ITS90ScalePTctes{T}
    A::T
    B::T
    C::T
    D::T

    resistance_low::Any
    resistance_high::Any
    temperature_low::Any
    temperature_high::Any

    function ITS90ScalePTctes()
        A = [
            -2.135_347_29,
            3.183_247_20,
            -1.801_435_97,
            0.717_272_04,
            0.503_440_27,
            -0.618_993_95,
            -0.053_323_22,
            0.280_213_62,
            0.107_152_24,
            -0.293_028_65,
            0.044_598_72,
            0.118_686_32,
            -0.052_481_34,
        ]
        B = [
            0.183_324_722,
            0.240_9753_03,
            0.209_108_771,
            0.190_439_972,
            0.142_648_498,
            0.077_993_465,
            0.012_475_611,
            -0.032_267_127,
            -0.075_291_522,
            -0.056_470_670,
            0.076_201_285,
            0.123_893_204,
            -0.029_201_193,
            -0.091_173_542,
            0.001_317_696,
            0.026_025_526,
        ]
        C = [
            2.781_572_54,
            1.646_509_16,
            -0.137_143_90,
            -0.006_497_67,
            -0.002_344_44,
            0.005_118_68,
            0.001_879_82,
            -0.002_044_72,
            -0.000_461_22,
            0.000_457_24,
        ]
        D = [
            439.932_854,
            472.418_020,
            37.684_494,
            7.472_018,
            2.920_828,
            0.005_184,
            -0.963_864,
            -0.188_732,
            0.191_203,
            0.049_025,
        ]

        # resistance_low = Polynomials.Polynomial(A[end:-1:1])
        # resistance_high = Polynomials.Polynomial(C[end:-1:1])
        # temperature_low = Polynomials.Polynomial(B[end:-1:1])
        # temperature_high = Polynomials.Polynomial(D[end:-1:1])
        resistance_low = Polynomials.ImmutablePolynomial(A)
        resistance_high = Polynomials.ImmutablePolynomial(C)
        temperature_low = Polynomials.ImmutablePolynomial(B)
        temperature_high = Polynomials.ImmutablePolynomial(D)

        new{typeof(A)}(A,
            B,
            C,
            D,
            resistance_low,
            resistance_high,
            temperature_low,
            temperature_high)
    end
end
