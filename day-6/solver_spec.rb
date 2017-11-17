require "minitest/autorun"
require_relative "./solver_s"

describe SolverS do
    before do
        @solver = SolverS.new
        @instruction_set = [
            "turn on 0,0 through 999,999",
            "toggle 0,0 through 999,0",
            "turn off 499,499 through 500,500"
        ]
    end

    it "Should return the number of switched on lights as: 1Mn" do
        @solver.compute_lights_on([@instruction_set[0]]).must_equal(1_000_000)
        @solver.compute_lights_on([@instruction_set[1]]).must_equal(1_000)
        @solver.compute_lights_on([@instruction_set[2]]).must_equal(0)
        @solver.compute_lights_on(@instruction_set).must_equal(998_996)
    end

    it "should parse the instruction and return action and coordinates" do
        parsed_instruction = {
            action: "turn on",
            coordinates: [
                { x: 0, y: 0 },
                { x: 999, y: 999 }
            ]
        }
        @solver.parse_instruction(@instruction_set[0]).must_equal(parsed_instruction)
    end

    describe "get_action" do
        it "should return the action as turn on" do
            @solver.get_action(@instruction_set[0]).must_equal("turn on")
            @solver.get_action(@instruction_set[1]).must_equal("toggle")
            @solver.get_action(@instruction_set[2]).must_equal("turn off")
        end
    end

    describe "get_coordinates" do
        it "should return the action as turn on" do
            @solver.get_coordinates("0,0 through 999,999").must_equal([
                {x: 0, y: 0},
                {x: 999, y: 999}
            ])
            @solver.get_coordinates("0,0 through 999,0").must_equal([
                {x: 0, y: 0},
                {x: 999, y: 0}
            ])
            @solver.get_coordinates("499,499 through 500,500").must_equal([
                {x: 499, y: 499},
                {x: 500, y: 500}
            ])
        end
    end

end