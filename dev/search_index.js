var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = TemperatureSensors","category":"page"},{"location":"#TemperatureSensors","page":"Home","title":"TemperatureSensors","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for TemperatureSensors.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [TemperatureSensors]","category":"page"},{"location":"#TemperatureSensors.NotImplementerError","page":"Home","title":"TemperatureSensors.NotImplementerError","text":"NotImplementerError <: Exception\n\nThis error is used to flag if some functionality is not yet implemented.\n\n\n\n\n\n","category":"type"},{"location":"#TemperatureSensors.OutOfRangeError","page":"Home","title":"TemperatureSensors.OutOfRangeError","text":"OutOfRangeError <: Exception\n\nThis error is used to flag if a equation is being applied out of the applicable range.\n\n\n\n\n\n","category":"type"},{"location":"#TemperatureSensors.temperature-Tuple{Any, Sensor}","page":"Home","title":"TemperatureSensors.temperature","text":"temperature(parameter::Real, sensor::Sensor)\n\nBase function for generic type of sensor. This function trhows error as is the generic function which deals with\n\nArguments\n\nparameter::Real: the value of the independant variable. If for resistive sensors the value of resistance in ohms with which to compute the temperature.\nsensor::Sensor: the sensor used to measure temperature, any subtype of Sensor is valid.\n\nExample\n\njulia> temperature(100.0,ThermocoupleJ())\nERROR: TemperatureSensors.NotImplementerError()\n\nOutput\n\nnothing: the general implementation is used when the sensor is not implemented so both an error is thown and nothing value is returned.\n\n\n\n\n\n","category":"method"},{"location":"#TemperatureSensors.temperature-Union{Tuple{X}, Tuple{X, ITS90PT100}} where X","page":"Home","title":"TemperatureSensors.temperature","text":"temperature(resistance::X, sensor::ITS90PT100) where {X}\n\nFunction used to calculate the temperature of a Resistance Temperature Device (RTD) based on the ITS-90 PT standard. The interpolation equation was developed for the ITS-90 temperature definition and is defined by parts based on the temperature reference adopted. The temperature function applies only the deviation formula given by:\n\nW-Wr=a_5left(W-1right)+b_5left(W-1right)^2\n\nor\n\nW-Wr=a_10left(W-1right)\n\nThe first equation is used when the resistance provided is smaller than the value of sensor.ITS90_transition_resistance, which is the value of the resistance of the RTD at 273.15K.\n\nThe value of W is defined by:\n\nW = fracresistancesensorRTPW\n\nThe variable Wr is computed from the general interpolators defined in ITS90ScalePTctes, one interpolator is defined for higher temepratures and another for lower termperatures.\n\nSee ITS-90 paper for further reference.\n\nArguments\n\nresistence: The value of the resistance measured in the RTD in ohms.\nsensor::ITS90PT100: The sensor used to measure temperature. Calibration with the parameters from the ITS-90 equations are required.\n\nExample\n\njulia> sensor = ITS90PT100(-2.0386711E-2, 3.3068936E-3, -1.9700442E-02, 100.0121)\nITS90PT100(-0.020386711, 0.0033068936, -0.019700442, 100.0121, 100.01209954383037)\n\njulia> temperature(sensor.ITS90_transition_resistance, sensor)\n273.1599988338994\n\n\n\n\n\n","category":"method"}]
}
