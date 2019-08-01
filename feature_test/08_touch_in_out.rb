require_relative '../lib/oystercard.rb'

card = Oystercard.new(50)

puts "in journey should be false and it is #{card.in_journey?}"

card.touch_in

puts "in journey should be true and it is #{card.in_journey?}"

card.touch_out

puts "in journey should be false and it is #{card.in_journey?}"
