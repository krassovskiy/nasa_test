class Calculate
  include Dry::Monads[:result, :do]

  def call
  end

  private

    def fuel_calculation(mass, gravity, operation)
      send("#{operation.to_s}_formula", mass, gravity).to_i
    end

    def land_formula(mass, gravity)
      mass * gravity * 0.033 - 42
    end

    def launch_formula(mass, gravity)
      mass * gravity * 0.042 - 33
    end
end
