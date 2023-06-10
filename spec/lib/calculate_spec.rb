RSpec.describe App['calculate'].class do
  describe '#calculate_fuel_for_maneuver' do
    before do
      @mass = 28801
      @gravity = 9.807
      @calculate = App['calculate']
    end

    it 'return rounded down number with land operation' do
      expect(@calculate.send(:calculate_fuel_for_maneuver, @mass, @gravity, :land)).to eq 9278
    end

    it 'return rounded down number with launch operation' do
      expect(@calculate.send(:calculate_fuel_for_maneuver, @mass, @gravity, :launch)).to eq 11829
    end
  end

  context 'Apollo 11 mission' do
    describe '#call' do
      before do
        @ship_weight = 28801
        @flight_params = [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]
        @calculate = App['calculate']
      end

      it 'return amount fuel of all ship maneuvers rounded down' do
        expect(@calculate.call(ship_weight: @ship_weight, flight_params: @flight_params)).to eq 51898
      end
    end
  end

  context 'Mission on Mars' do
    describe '#call' do
      before do
        @ship_weight = 14606
        @flight_params = [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
        @calculate = App['calculate']
      end

      it 'return amount fuel of all ship maneuvers rounded down' do
        expect(@calculate.call(ship_weight: @ship_weight, flight_params: @flight_params)).to eq 33388
      end
    end
  end

  context 'Passenger ship' do
    describe '#call' do
      before do
        @ship_weight = 75432
        @flight_params = [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
        @calculate = App['calculate']
      end

      it 'return amount fuel of all ship maneuvers rounded down' do
        expect(@calculate.call(ship_weight: @ship_weight, flight_params: @flight_params)).to eq 212161
      end
    end
  end

  context 'incorrect params for mission' do
    describe '#call' do
      before do
        @ship_weight = '124124'
        @flight_params = []
        @calculate = App['calculate']
      end

      it 'return message with incorrect params' do
        expect(@calculate.call(ship_weight: @ship_weight, flight_params: @flight_params)[0]).to eq :incorrect_params        
      end

      it 'errors count must be qreater than 0' do
        expect(@calculate.call(ship_weight: @ship_weight, flight_params: @flight_params)[1].count).to be > 0        
      end
    end
  end
end
