require_relative '../lib/oystercard.rb'

card0 = Oystercard.new

if card0.balance == 0
  puts 'Card created with 0 balance as default'
else
  puts 'card has wrong default balance'
end

card1 = Oystercard.new(100)

if card1.balance == 100
  puts 'Card created with 100 balance as custom'
else
  puts 'card has wrong custom balance'
end
