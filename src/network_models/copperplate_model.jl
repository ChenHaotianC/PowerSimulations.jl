function add_constraints!(
    container::OptimizationContainer,
    ::Type{T},
    sys::U,
    model::NetworkModel{V},
    S::Type{V},
) where {
    T <: CopperPlateBalanceConstraint,
    U <: PSY.System,
    V <: Union{CopperPlatePowerModel, StandardPTDFModel, PTDFPowerModel},
}
    time_steps = get_time_steps(container)
    expressions = get_expression(container, ActivePowerBalance(), U)
    constraint = add_constraints_container!(container, T(), U, time_steps)
    for t in time_steps, k in keys(model.subnetworks)
        constraint[t] = JuMP.@constraint(container.JuMPmodel, expressions[k, t] == 0)
    end

    return
end
