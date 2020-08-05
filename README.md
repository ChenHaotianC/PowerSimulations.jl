# PowerSimulations

[![Build Status](https://img.shields.io/travis/com/NREL-SIIP/PowerSimulations.jl/master.svg)](https://travis-ci.com/NREL-SIIP/PowerSimulations.jl)
[![codecov](https://codecov.io/gh/NREL-SIIP/PowerSimulations.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/NREL-SIIP/PowerSimulations.jl)
[![Documentation](https://github.com/NREL-SIIP/PowerSimulations.jl/workflows/Documentation/badge.svg)](https://nrel-siip.github.io/PowerSimulations.jl/latest)
[![Join the chat at https://gitter.im/NREL/PowerSimulations.jl](https://badges.gitter.im/NREL/PowerSimulations.jl.svg)](https://gitter.im/NREL/PowerSimulations.jl)

## The current implementation of the functionalities can be seen in the test codes.

`PowerSimulations.jl` is a Julia package for power system modeling and simulation of Power Systems operations. The objectives of the package are:

- Provide a flexible modeling framework that can accommodate problems of different complexity and at different time-scales.

- Streamline the construction of large scale optimization problems to avoid repetition of work when adding/modifying model details.

- Exploit Julia's capabilities to improve computational performance of large scale power system quasi-static simulations.

The flexible modeling framework is enabled through a modular set of capabilities that enable scalable power system analysis and exploration of new analysis methods. The modularity of PowerSimulations results from the structure of the simulations enabled by the package:

 - _Simulations_ define a set of problems that can be solved using numerical techniques.

For example, an annual production cost modeling simulation can be created by formulating a unit commitment model against system data to assemble a set of 365 daily time-coupled scheduling problems.

### _Simulations_ enabled by PowerSimulations:
 - Production Cost Modeling
 - Load Flow and Contingency Analysis - _TODO_

### _Model_ formulations contained in PowerSimulations:
 - [Unit Commitment](https://en.wikipedia.org/wiki/Unit_commitment_problem_in_electrical_power_production)
 - [Economic Dispatch](https://en.wikipedia.org/wiki/Economic_dispatch)

## Installation

```julia
julia> ]
(v1.5) pkg> add PowerSystems
(v1.5) pkg> add PowerSimulations
```
## Usage

`PowerSimulations.jl` uses [PowerSystems.jl](https://github.com/NREL/PowerSystems.jl) to handle the data used in the simulations.

```julia
using PowerSimulations
using PowerSystems
```

## Development

Contributions to the development and enahancement of PowerSimulations is welcome. Please see [CONTRIBUTING.md](https://github.com/NREL-SIIP/PowerSimulations.jl/blob/master/CONTRIBUTING.md) for code contribution guidelines.

## License

PowerSimulations is released under a BSD [license](https://github.com/NREL/PowerSimulations.jl/blob/master/LICENSE). PowerSimulations has been developed as part of the Scalable Integrated Infrastructure Planning (SIIP)
initiative at the U.S. Department of Energy's National Renewable Energy Laboratory ([NREL](https://www.nrel.gov/))
