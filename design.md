# Oystercard

Written before tackling all the steps.

## Focus Goals

***I write code that is easy to change***

Writing easy to change software is highly prized amongst developers and employers. By developers because most of a developer's time is spent changing software. By employers because their teams can deliver value to customers faster.

***I can test-drive my code***

Tested software is easier to change because you can tell when it's broken just by running a command, even the tricky edge cases.

***I can build with objects***

Most code in the world is structured in small pieces called objects. This is done because it is easier to change than having everything in one place.


---

## User Stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
---

## Design scratchpad:

- I want money on my card
- I want to add money to my card
- I don't want to put too much money on my card # Limits the maximum balance
- I need my fare deducted from my card
- I need to touch in and out
- I need to have the minimum amount for a single journey
- I need to pay for my journey when it's complete
- I need to know where I've travelled from
- I want to see to all my previous trips
- I need a penalty charge deducted if I fail to touch in or out
- I need to have the correct fare calculated
- I want to know what zone a station is in


Objects:
- Oystercard
  - `.new(balance = 0)` : set balance ?? don't need this.
  - `.top_up(amount)` : Will fail if balance over card.max_balance
  - `@max_balance` : Instance variable which limits the amount of money on the card
  - `.balance` : Shows user `@balance` value.
  - `.deduct(amount)`
  - `.touch_in(station)` : fail if card_balance is too low. Fail if 'still travelling' / or deduct a penalty and then set to 'traveling'
  - `.touch_out(station)` : Will add journey to @trips. Fail if not "touched in". Will pay for journey. If not 'travelling' then apply penalty.
  - `@trips` : keeps a record of full trips. = [[station1,station2],[station3,station4],[nil,station5],[station6,nil]]?
  -  `.penalty(type/amount?)` : (private) Will deduct an additional cost from the card. Type: not touched in, not touched out.
- Station
  - `.new(zone, name)` : Set the zone and name of the station
  - `.what_zone` : returns the zone of the station
- Fare calc :
  - `fare_total(station1 ,station2)` : Check what zone the stations are in and return a fare.


