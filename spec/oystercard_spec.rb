require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }

  it { is_expected.to respond_to(:balance) }

  it 'has a default balance of 0 on initialization' do
    expect(oystercard.balance).to eq 0
  end


end