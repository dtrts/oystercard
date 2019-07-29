require_relative '../lib/oystercard.rb'

card = Oystercard.new(50)

station_in = 'Lambeth'
station_out = 'Euston'

puts "expect card.journeys to show [] and it shows #{card.journeys}"

card.touch_in(station_in)
card.touch_out(station_out)
puts ' num of journeys should be 1 and is #{card.journey.count}'
puts 'expect card.journeys to show [{entry_Station: "Lambeth",exit_station: "Euston"}] and it shows #{card.journeys}'
