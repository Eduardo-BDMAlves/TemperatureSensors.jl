using TemperatureSensors
using Documenter

DocMeta.setdocmeta!(TemperatureSensors, :DocTestSetup, :(using TemperatureSensors); recursive=true)

makedocs(;
    modules=[TemperatureSensors],
    authors="Eduardo-BDMAlves <eduardo.alves@polo.ufsc.br>",
    repo="https://github.com/Eduardo-BDMAlves/TemperatureSensors.jl/blob/{commit}{path}#{line}",
    sitename="TemperatureSensors.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Eduardo-BDMAlves.github.io/TemperatureSensors.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Eduardo-BDMAlves/TemperatureSensors.jl",
    devbranch="master",
)
