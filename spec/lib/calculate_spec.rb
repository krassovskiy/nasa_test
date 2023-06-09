RSpec.describe App['calculate'].class do
  describe '#fuel_calculation' do
    before do
      @mass = 28801
      @gravity = 9.807
      @calculate = App['calculate']
    end

    it 'land success' do
      expect(@calculate.send(:fuel_calculation, @mass, @gravity, :land)).to eq 9278
    end

    it 'launch success' do
      expect(@calculate.send(:fuel_calculation, @mass, @gravity, :launch)).to eq 11829
    end
  end
end