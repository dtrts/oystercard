require_relative '../lib/oystercard.rb'

card0 = Oystercard.new

puts "Starting balance should be 0 and is #{card0.balance}"

top_up_val = Oystercard::MAXIMUM_BALANCE + rand(1..100)

begin
  card0.top_up(top_up_val)
rescue StandardError
  puts 'card refuses to be topped up over #{Oystercard::MAXIMUM_BALANCE} which is right'
else
  puts 'ERR card should not have been allowed to be topped up'
end
