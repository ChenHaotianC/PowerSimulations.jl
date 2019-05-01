# PowerSimulations

[![Build Status](https://img.shields.io/travis/com/NREL/PowerSimulations.jl/master.svg)](https://travis-ci.com/NREL/PowerSimulations.jl)
[![Build status](https://img.shields.io/appveyor/ci/kdheepak/powersimulations-jl/master.svg)](https://ci.appveyor.com/project/kdheepak/powersimulations-jl)
[![Join the chat at https://gitter.im/NREL/PowerSimulations.jl](https://badges.gitter.im/NREL/PowerSimulations.jl.svg)](https://gitter.im/NREL/PowerSimulations.jl)

**PowerSimulations is currently work in progress. Many of the functionalities are not currently available. Please follow the instructions below if you want to test some of the code already developed.**

## The current implementation of the functionalities can be seen in the test codes.

PowerSimulations.jl is a Julia package for power system simulations. The objectives of the PowerSimulations package are:
- Provide a flexible modeling framework that can accommodate problems of different complexity and at different time-scales.

- Streamline the construction of large scale optimization problems to avoid repetition of work when adding/modifying model details.

- Exploit Julia's capabilities to improve computational performance of large scale power system simulations.

The flexible modeling framework is enabled through a modular set of capabilities that enable scalable power system analysis and exploration of new analysis methods. The modularity of PowerSimulations results from the structure of the simulations enabled by the package:

 - _Simulations_ define a set of problems that can be solved using numerical techniques.


 - _Problems_ are generated by expressing _model formulations_ against [_system data_](https://github.com/NREL/PowerSystems.jl)

For example, an annual production cost modeling simulation can be created by formulating a unit commitment model against system data to assemble a set of 365 daily time-coupled scheduling problems.

### _Simulations_ enabled by PowerSimulations:
 - Production Cost Modeling
 - Capacity Expansion Modeling - _TODO_
 - Load Flow and Contingency Analysis - _TODO_

### _Model_ formulations contained in PowerSimulations:
 - [Unit Commitment](https://en.wikipedia.org/wiki/Unit_commitment_problem_in_electrical_power_production)
 - [Economic Distpatch](https://en.wikipedia.org/wiki/Economic_dispatch).
 - [DC Power Flow](https://www.mech.kuleuven.be/en/tme/research/energy_environment/Pdf/wpen2014-12.pdf)

## Installation

This package is not yet registered and relies on unreleased branches from other packages. In order to install `PowerSimulations.jl` you need to have installed the proper version of those packages.

**Until it is, things may change. It is perfectly
usable but should not be considered stable**.

You can install it by typing

```julia
pkg> add JuMP
pkg> add InfrastructureModels#moi-2
pkg> add PowerModels#moi-2
pkg> dev https://github.com/NREL/PowerSimulations.jl 
```
## Usage

Once installed, the `PowerSimulations` package can by going to the folder `.julia/dev/PowerSimulations` used by typing

```julia
julia> ]
(v0.7) pkg> activate .
(PowerSimulations) pkg> instantiate
```

## Development

Contributions to the development and enahancement of PowerSimulations is welcome. Please see [CONTRIBUTING.md](https://github.com/NREL/PowerSimulations.jl/blob/master/CONTRIBUTING.md) for code contribution guidelines.


## License

PowerSimulations is released under a BSD [license](https://github.com/NREL/PowerSimulations.jl/blob/master/LICENSE). PowerSimulations has been developed as part of the Scalable Integrated Infrastructure Planning (SIIP)
initiative at the U.S. Department of Energy's National Renewable Energy Laboratory ([NREL](https://www.nrel.gov/))
