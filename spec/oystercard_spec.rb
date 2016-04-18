require 'oystercard'

describe Oystercard do
	subject(:oystercard) {described_class.new}
	it 'I want an oystercard with a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	describe '#top up balance' do

		it 'response to top up with 1 argument' do
			expect(oystercard).to respond_to(:top_up).with(1).argument
		end

		it 'adds money to the balance on oystercard'do 
			expect{oystercard.top_up 1}.to change{oystercard.balance}.by 1
		end

		it 'raises an expection if the balance goes above £90' do 
			MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
    		subject.top_up(MAXIMUM_BALANCE)
    		expect{ subject.top_up 1 }.to raise_error "Maximum balance #{MAXIMUM_BALANCE}exceeded"
		end
	end

	describe '#deduct balance' do
		it 'deducts an amount from balance on oystercard' do 
			oystercard.top_up(20)
			expect{oystercard.deduct 3}.to change{oystercard.balance}.by -3
		end
	end

	describe '#touch in/out support' do
		it "can touch in" do
			oystercard.touch_in
  			expect(oystercard).to be_in_journey
		end

		it "can touch out" do
  			oystercard.touch_in
  			oystercard.touch_out
  			expect(oystercard).not_to be_in_journey
		end

		it 'is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end


	end
end