Dry::Validation.load_extensions(:monads)

module Contracts
  class MissionContract < Dry::Validation::Contract
    params do
      required(:ship_weight).filled
      required(:flight_params).filled
    end

    rule(:ship_weight) do
      unless [Integer, Float].include?(value.class)
        key.failure('must be a number')
      end
    end

    rule(:flight_params) do
      unless value.all?(Array)
        key.failure('arguments must be an array')
      end

      unless value.all?{ |el| el.size == 2 }
        key.failure('length of every argument must be equal 2')
      end
      
      unless value.all?{ |el| [:land, :launch].include?(el[0]) }
        key.failure('first argument must be :land or :launch')
      end

      unless value.all?{ |el| [Integer, Float].include?(el[1].class) }
        key.failure('second argument in arrays must be a number')
      end
    end
  end
end