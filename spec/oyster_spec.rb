require 'oyster'

describe Oyster do
  subject(:oyster) {described_class.new}

  it 'has a balance of 0 when initialized' do
    expect(oyster.balance).to eq 0
  end

  context '#top_up' do
  	it 'should increase the balance by the amount passed' do
  		oyster.top_up(20)
  		expect(oyster.balance).to eq 20
  	end
    it 'should raise an error if trying to exceed limit' do
      oyster.top_up(Oyster::LIMIT)
      expect{oyster.top_up(1)}.to raise_error "Balance cannot exceed #{Oyster::LIMIT}!"
    end
  end	

end