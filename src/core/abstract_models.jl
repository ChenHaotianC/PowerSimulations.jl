export PowerSimulationModel
export SimulationModel
export PowerResults

abstract type AbstractPowerSimulationType end

mutable struct PowerSimulationModel{T<:AbstractPowerSimulationType}
    cost::Function
    device::Any
    dynamics::Function
    network::Function
    system::PowerSystems.PowerSystem
    model::JuMP.Model
end

mutable struct SimulationModel
    model::PowerSimulationModel
    periods::Int
    resolution::Int
    date_from::DateTime
    date_to::DateTime
    lookahead_periods::Int
    lookahead_resolution::Int
    reserve_products::Any
    dynamic_analysis::Bool
    forecast::Any #Need to define this properly
    #A constructor here has to return the model based on the data, the time is AbstractModel
end

 mutable struct PowerResults
    ThermalGeneration::Union{Nothing,DataFrame}
    RenewableGEneration::Union{Nothing,DataFrame}
    HydroGeneration::Union{Nothing,DataFrame}
    Storage::Union{Nothing,DataFrame}
    Load::Union{Nothing,DataFrame}
    SolverOutput::Union{Nothing,Dict}
end
