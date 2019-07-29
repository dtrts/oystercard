require_relative '../lib/oystercard.rb'
card = Oystercard.new(20)

card.touch_in
card.touch_out
if card.balance < 20

  puts '*insert longest yeah boi ever*'
else
  puts 'i move away from the keyboard to breathe in'
end
