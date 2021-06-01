require 'oystercard'

RSpec.describe Oystercard do 
  it 'shows the balance of the card' do
    expect(subject.balance).to eq(0)
  end
end