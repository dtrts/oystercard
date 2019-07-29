require_relative '../lib/oystercard.rb'

card0 = Oystercard.new(90)

card0.deduct(10)

puts "card0 balance should be 80 and is #{card0.balance}"
