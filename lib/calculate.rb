class Calculate
  include Dry::Monads[:result, :do]

  def call(ship_weight:, flight_params:)
    weight_of_fuel = 0

    flight_params.reverse.each do |param|
      operation, gravity = param

      fuel_for_ship = fuel_calculation(ship_weight + weight_of_fuel, gravity, operation)
      fuel_for_fuel = fuel_for_ship
      sum_of_fuel = 0

      mass = fuel_for_fuel

      while true do 
        uncalculated_fuel = fuel_calculation(mass, gravity, operation)        
        mass = uncalculated_fuel
        if uncalculated_fuel <= 0
          break
        end
        sum_of_fuel += uncalculated_fuel        
      end
      
      weight_of_fuel += fuel_for_ship + sum_of_fuel
    end

    return weight_of_fuel

    
    # total_fuel = 0

    # flight_params.reverse.each do |param|
    #   operation, gravity = param

    #   sum_of_fuel = 0
    #   mass = ship_weight

    #   while true do
    #     uncalculated_fuel = fuel_calculation(mass, gravity, operation)
    #     sum_of_fuel += uncalculated_fuel        
    #     mass = uncalculated_fuel        
    #     if uncalculated_fuel <= 0
    #       break
    #     end
    #   end

    #   total_fuel += sum_of_fuel
    # end

    # return total_fuel
  end

  private

    def fuel_calculation(mass, gravity, operation)
      send("#{operation.to_s}_formula", mass, gravity)
    end

    def land_formula(mass, gravity)
      (mass * gravity * 0.033 - 42).to_i
    end

    def launch_formula(mass, gravity)
      (mass * gravity * 0.042 - 33).to_i
    end
end
