require_relative '../lib/oystercard.rb'

card = Oystercard.new(0)

begin
  card.touch_in # expect error
rescue StandardError
  puts 'Error called because no money. V.good'
else
  puts 'ERR no error'
end
