# Definitions

## A

* *Attributes*: Certain device formulations can be customized by specifying attributes that will include/remove certain variables, expressions and/or constraints. For example, in `StorageSystemsSimulations.jl`, the device formulation of `StorageDispatchWithReserves` can be specified with the following dictionary of attributes:
```julia
set_device_model!(
    template,
    DeviceModel(
        GenericBattery,
        StorageDispatchWithReserves;
        attributes=Dict{String, Any}(
            "reservation" => false,
            "cycling_limits" => false,
            "energy_target" => false,
            "complete_coverage" => false,
            "regularization" => false,
        ),
    ),
)
```
Changing the attributes between `true` or `false` can enable/disable multiple aspects of the formulation.

## C

* *Chronologies:* In `PowerSimulations.jl`, chronologies define where information is flowing. There are two types of chronologies. 1) **inter-stage chronologies** (`InterProblemChronology`) that define how information flows between stages. e.g. day-ahead solutions are used to inform economic dispatch problems; and 2) **intra-stage chronologies** (`IntraProblemChronology`) that define how information flows between multiple executions of a single stage. e.g. the dispatch setpoints of the first period of an economic dispatch problem are constrained by the ramping limits from setpoints in the final period of the previous problem.

## D

* *Decision Problem*: A decision problem calculates the desired system operation based on forecasts of uncertain inputs and information about the state of the system. The output of a decision problem represents the policies used to drive the set-points of the system's devices, like generators or switches, and depends on the purpose of the problem. See the [Decision Model Tutorial](@ref op_problem_tutorial) to learn more about solving individual problems.

* *Device Formulation*: The model of a device that is incorporated into a large system optimization models. For instance, the storage device model used inside of a Unit Commitment (UC) problem. A device model needs to follow some requirements to be integrated into operation problems. For more information about valid `DeviceModel`s and their mathematical representations, check out the [Formulation Library](@ref formulation_intro).

## E

* *Emulation Problem*: An emulation problem is used to mimic the system's behavior subject to an incoming decision and the realization of a forecasted inputs. The solution of the emulator produces outputs representative of the system performance when operating subject the policies resulting from the decision models.

## F

* *FeedForward*: The definition of exactly what information is passed using the defined chronologies is accomplished using FeedForwards. Specifically, a FeedForward is used to define what to do with information being passed with an inter-stage chronology in a Simulation. The most common FeedForward is the `SemiContinuousFeedForward` that affects the semi-continuous range constraints of thermal generators in the economic dispatch problems based on the value of the (already solved) unit-commitment variables.

## H

* *Horizon*: The number of steps in the look-ahead of a decision problem. For instance, a Day-Ahead problem usually has a 48 step horizon. Check the time [Time Series Data Section in PowerSystems.jl](https://nrel-sienna.github.io/PowerSystems.jl/stable/modeler_guide/time_series/)

## I

* *Interval*: The amount of time between updates to the decision problem. For instance, Day-Ahead problems usually have a 24-hour intervals and Real-Time problems have 5-minute intervals. Check the time [Time Series Data Section in PowerSystems.jl](https://nrel-sienna.github.io/PowerSystems.jl/stable/modeler_guide/time_series/)

## R

* *Resolution*: The amount of time between timesteps in a simulation. For instance 1-hour or 5-minutes. In Julia these are defined using the syntax `Hour(1)` and `Minute(5)`. Check the time [Time Series Data Section in PowerSystems.jl](https://nrel-sienna.github.io/PowerSystems.jl/stable/modeler_guide/time_series/)

## S

* *Simulation*: A simulation is a pre-determined sequence of decision problems in a way that solving it, resembles the solution procedures commonly used by operators. The most common simulation model is the solution of a Unit Commitment and Economic Dispatch sequence of problems.

* *Solver*: A solver is a software package that incorporates algorithms for finding solutions to one or more classes of optimization problem. For example, FICO Xpress is a commercial optimization solver for linear programming (LP), convex quadratic programming (QP) problems, convex quadratically constrained quadratic programming (QCQP), second-order cone programming (SOCP) and their mixed integer counterparts. **A solver is required to be specified** in order to solve any computer optimization problem.

## T

* *Template*: A `ProblemTemplate` is just a collection of `DeviceModel`s that allows the user to specify the formulations of each set of devices (by device type) independently so that the modeler can adjust the level of detail according to the question of interest and the available data. For more information about valid `DeviceModel`s and their mathematical representations, check out the [Formulation Library](@ref formulation_intro).