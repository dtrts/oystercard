require_relative '../lib/oystercard.rb'

card0 = Oystercard.new

puts "New card balance #{card0.balance}"

puts 'Adding 50 to balance'
card0.top_up(50)
puts "Card balance is now #{card0.balance}"
