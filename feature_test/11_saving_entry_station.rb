require_relative '../lib/oystercard.rb'

card = Oystercard.new(10)

station = 'North Lambeth'

card.touch_in(station)

puts card.entry_station
