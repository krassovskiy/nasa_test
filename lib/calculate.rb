class Calculate
  include Dry::Monads[:result]

  def call(ship_weight:, flight_params:)
    result = App['contracts.mission_contract'].call(ship_weight: ship_weight, flight_params: flight_params)

    result.success? ? calculate_mission(ship_weight, flight_params) : [:incorrect_params, result.errors.to_h]
  end

  private

    def calculate_mission(ship_weight, flight_params)
      total_weight_of_fuel = 0

      flight_params.reverse.each do |param|
        operation, gravity = param
        total_weight_of_fuel += calculate_fuel_needed_to_maneuver_with_additional_fuel(ship_weight, gravity, operation, total_weight_of_fuel)
      end

      return total_weight_of_fuel
    end

    def calculate_fuel_needed_to_maneuver_with_additional_fuel(ship_weight, gravity, operation, total_weight_of_fuel)
      fuel_needed_to_ship = calculate_fuel_for_maneuver(ship_weight + total_weight_of_fuel, gravity, operation)
      mass = fuel_needed_to_ship
      calculated_fuel = 0

      while true do
        uncalculated_fuel = calculate_fuel_for_maneuver(mass, gravity, operation)
        mass = uncalculated_fuel

        if uncalculated_fuel <= 0
          break
        end

        calculated_fuel += uncalculated_fuel
      end

      return calculated_fuel + fuel_needed_to_ship
    end

    def calculate_fuel_for_maneuver(mass, gravity, operation)
      send("#{operation.to_s}_formula", mass, gravity)
    end

    def land_formula(mass, gravity)
      (mass * gravity * 0.033 - 42).to_i
    end

    def launch_formula(mass, gravity)
      (mass * gravity * 0.042 - 33).to_i
    end
end
