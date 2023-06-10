require 'config_spec'

RSpec.describe App['contracts.mission_contract'].class do
  before do
    @contract = App['contracts.mission_contract']
    @ship_weight = 28801
    @flight_params = [
      [:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]
    ]
  end

  it 'correct params' do
    expect(@contract.call(ship_weight: @ship_weight, flight_params: @flight_params).errors.count).to eq 0
  end

  context 'validations' do
    context 'ship weight' do
      it 'must be filled' do
        expect(@contract.call(ship_weight: nil, flight_params: @flight_params).errors[:ship_weight][0]).to eq 'must be filled'
      end

      it 'must be a number' do
        ['asd', [1,2,3], {test: 'test'}].each do |ship_weight|
          expect(@contract.call(ship_weight: ship_weight, flight_params: @flight_params).errors[:ship_weight][0]).to eq 'must be a number'
        end
      end
    end

    context 'flight params' do
      it 'must be filled' do
        [nil].each do |flight_params|
          expect(@contract.call(ship_weight: @ship_weight, flight_params: flight_params).errors[:flight_params][0]).to eq 'must be filled'
        end
      end

      it 'every argument in flight params must be an array' do
        [[[:launch, 22], {}], ['1asf', [:land, 125]], [{test: 'test'}, 11]].each do |flight_params|
          expect(@contract.call(ship_weight: @ship_weight, flight_params: flight_params).errors[:flight_params][0]).to eq 'arguments must be an array'
        end
      end

      it 'length of every array in flight params must be equal 2' do
        [[[:land, 123, 12242]], [[123]]].each do |flight_params|
          expect(@contract.call(ship_weight: @ship_weight, flight_params: flight_params).errors[:flight_params][0]).to eq 'length of every argument must be equal 2'
        end
      end

      it 'first argument in arrays must be either :land or :launch' do
        [[[:symbol_test, 222.22]], [[:test, 2555]]].each do |flight_params|
          expect(@contract.call(ship_weight: @ship_weight, flight_params: flight_params).errors[:flight_params][0]).to eq 'first argument must be :land or :launch'
        end
      end

      it 'second argument in arrays must be a number' do
        [[[:land, 'test']], [[:launch, :atom_test]], [[:land, {test: 'test'}]]].each do |flight_params|
          expect(@contract.call(ship_weight: @ship_weight, flight_params: flight_params).errors[:flight_params][0]).to eq 'second argument in arrays must be a number'
        end
      end
    end
  end
end