@doc """

    NotImplementerError <: Exception

This error is used to flag if some functionality is not yet implemented.

"""
struct NotImplementerError <: Exception end





@doc """

    OutOfRangeError <: Exception

This error is used to flag if a equation is being applied out of the applicable range.

"""
struct OutOfRangeError <: Exception end
