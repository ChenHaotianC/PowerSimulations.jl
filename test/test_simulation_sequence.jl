@testset "Simulation Sequence Correct Execution Order" begin
problems =  SimulationProblems(
        DAUC = OperationsProblem(MockOperationProblem; horizon = 48),
        HAUC = OperationsProblem(MockOperationProblem; horizon = 24),
        ED = OperationsProblem(MockOperationProblem; horizon = 12),
        AGC = OperationsProblem(MockOperationProblem; horizon = 6),
    )
    feedforward_chronologies = Dict(
        ("UC" => "HAUC") => Synchronize(periods = 24),
        ("HAUC" => "ED") => RecedingHorizon(),
        ("ED" => "AGC") => RecedingHorizon(),
    )
    ini_cond_chronology = InterStageChronology()
    intervals = Dict(
        "DAUC" => (Hour(24), Consecutive()),
        "HAUC" => (Hour(1), RecedingHorizon()),
        "ED" => (Minute(5), RecedingHorizon()),
        "AGC" => (Minute(1), Consecutive()),
    )
    test_sequence = SimulationSequence(
        problems = problems,
        feedforward_chronologies = feedforward_chronologies,
        intervals = intervals,
        ini_cond_chronology = ini_cond_chronology,
    )

    @test length(findall(x -> x == 4, test_sequence.execution_order)) == 24 * 60
    @test length(findall(x -> x == 3, test_sequence.execution_order)) == 24 * 12
    @test length(findall(x -> x == 2, test_sequence.execution_order)) == 24
    @test length(findall(x -> x == 1, test_sequence.execution_order)) == 1

    for name in PSI.get_problem_names(problems)
        @test problems[name].internal.simulation_info.sequence_uuid == test_sequence.uuid
    end

    test_sequence = SimulationSequence(
        problems = SimulationProblems(DAUC = OperationsProblem(MockOperationProblem; horizon = 48)),
        intervals = Dict("DAUC" => (Hour(24), Consecutive())),
        ini_cond_chronology = InterStageChronology(),
    )

    @test isa(test_sequence.ini_cond_chronology, IntraStageChronology)
    @test test_sequence.execution_order == [1]
end

@testset "Simulation Sequence invalid sequences" begin
    @test_throws ArgumentError SimulationSequence(
        problems = mock_uc_ed_simulation_problems(48, 12),
        intervals = Dict(
            "UC" => (Hour(24), Consecutive()),
            "ED" => (Hour(1), Consecutive()),
        ),
        feedforward = Dict(
            ("ED", :devices, :Generators) => SemiContinuousFF(
                binary_source_stage = PSI.ON,
                affected_variables = [PSI.ACTIVE_POWER],
            ),
        ),
        cache = Dict(("ED",) => TimeStatusChange(PSY.ThermalStandard, PSI.ON)),
        ini_cond_chronology = InterStageChronology(),
    )

    @test_throws IS.ConflictingInputsError SimulationSequence(
       problems = problems = mock_uc_ed_simulation_problems(24, 12),
        feedforward_chronologies = Dict(("UC" => "ED") => Synchronize(periods = 24)),
        intervals = Dict(
            "UC" => (Hour(2), Consecutive()),
            "ED" => (Hour(3), RecedingHorizon()),
        ),
        feedforward = Dict(
            ("ED", :devices, :Generators) => SemiContinuousFF(
                binary_source_stage = PSI.ON,
                affected_variables = [PSI.ACTIVE_POWER],
            ),
        ),
        cache = Dict(("ED",) => TimeStatusChange(PSY.ThermalStandard, PSI.ON)),
        ini_cond_chronology = InterStageChronology(),
    )
end

#= ASCII printing broken
    @testset "Test print methods of sequence ascii art" begin
        sequence_2 = SimulationSequence(
            order = Dict(1 => "UC", 2 => "ED"),
            step_resolution = Hour(1),
            feedforward_chronologies = Dict(("UC" => "ED") => RecedingHorizon(periods = 2)),
            horizons = Dict("UC" => 24, "ED" => 12),
            intervals = Dict(
                "UC" => (Hour(1), RecedingHorizon()),
                "ED" => (Minute(5), RecedingHorizon()),
            ),
            feedforward = Dict(
                ("ED", :devices, :Generators) => SemiContinuousFF(
                    binary_source_stage = PSI.ON,
                    affected_variables = [PSI.ACTIVE_POWER],
                ),
            ),
            ini_cond_chronology = InterStageChronology(),
        )

        sequence_4 = SimulationSequence(
            order = Dict(1 => "UC", 2 => "ED"),
            step_resolution = Hour(1),
            feedforward_chronologies = Dict(("UC" => "ED") => RecedingHorizon(periods = 4)),
            horizons = Dict("UC" => 24, "ED" => 12),
            intervals = Dict(
                "UC" => (Hour(1), RecedingHorizon()),
                "ED" => (Minute(5), RecedingHorizon()),
            ),
            feedforward = Dict(
                ("ED", :devices, :Generators) => SemiContinuousFF(
                    binary_source_stage = PSI.ON,
                    affected_variables = [PSI.ACTIVE_POWER],
                ),
            ),
            ini_cond_chronology = InterStageChronology(),
        )

        sequence_3 = SimulationSequence(
            order = Dict(1 => "UC", 2 => "ED"),
            step_resolution = Hour(1),
            feedforward_chronologies = Dict(("UC" => "ED") => RecedingHorizon(periods = 3)),
            horizons = Dict("UC" => 24, "ED" => 12),
            intervals = Dict(
                "UC" => (Hour(1), RecedingHorizon()),
                "ED" => (Minute(5), RecedingHorizon()),
            ),
            feedforward = Dict(
                ("ED", :devices, :Generators) => SemiContinuousFF(
                    binary_source_stage = PSI.ON,
                    affected_variables = [PSI.ACTIVE_POWER],
                ),
            ),
            ini_cond_chronology = InterStageChronology(),
        )

        sequence_5 = SimulationSequence(
            order = Dict(1 => "UC", 2 => "ED"),
            step_resolution = Hour(1),
            feedforward_chronologies = Dict(("UC" => "ED") => RecedingHorizon(periods = 2)),
            horizons = Dict("UC" => 24, "ED" => 12),
            intervals = Dict(
                "UC" => (Hour(1), RecedingHorizon()),
                "ED" => (Minute(5), RecedingHorizon()),
            ),
            feedforward = Dict(
                ("ED", :devices, :Generators) => RangeFF(
                    variable_source_stage_ub = PSI.ON,
                    variable_source_stage_lb = PSI.ON,
                    affected_variables = [PSI.ACTIVE_POWER],
                ),
            ),
            ini_cond_chronology = InterStageChronology(),
        )

        sequence_13 = SimulationSequence(
            order = Dict(1 => "UC", 2 => "ED"),
            step_resolution = Hour(1),
            feedforward_chronologies = Dict(
                ("UC" => "ED") => RecedingHorizon(periods = 13),
            ),
            horizons = Dict("UC" => 24, "ED" => 12),
            intervals = Dict(
                "UC" => (Hour(1), RecedingHorizon()),
                "ED" => (Minute(5), RecedingHorizon()),
            ),
            feedforward = Dict(
                ("ED", :devices, :Generators) => SemiContinuousFF(
                    binary_source_stage = PSI.ON,
                    affected_variables = [PSI.ACTIVE_POWER],
                ),
            ),
            ini_cond_chronology = InterStageChronology(),
        )
        list = [sequence_2, sequence_3, sequence_4, sequence_5, sequence_13]
        _test_plain_print_methods(list)
        stage_1 = FakeStagesStruct(Dict(1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6)) # testing 5 stages
        stage_3 = FakeStagesStruct(Dict(1 => 1, 2 => 100)) #testing 3 digits
        stage_4 = FakeStagesStruct(Dict(1 => 1, 2 => 1000)) #testing 4 digits
        stage_12 = FakeStagesStruct(Dict(1 => 1, 2 => 12, 3 => 5, 4 => 6))
        list = [stage_1, stage_3, stage_4, stage_12]
        _test_plain_print_methods(list)
    end
end
=#
