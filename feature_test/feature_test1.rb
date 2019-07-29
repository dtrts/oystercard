require_relative '../lib/card.rb'
require_relative '../lib/station.rb'
# Feature Test

# Making a a card
my_card = Oystercard.new
my_card.top_up(100)

# Making Stations
hampstead = Station.new(2)
euston = Station.new(1)

my_card.top_up(50)
puts my_card.balance # expect to eq 50
my_card.touch_in(hampstead)
my_card.touch_in(euston)

puts my_card.balance # expect to eq < 50

puts my_card.trips # show trips
