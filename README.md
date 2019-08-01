# Oystercard

## Description

This is a simple project in Ruby to simulate the usage of an Oystercard. The purpose was to develop skills in writing encapsulated OO code using TDD. Dependency injection is also used to ensure unit tests do not have unnecessary dependencies.


## Configuration

Ruby v.2.6.3.

Use [Bundler](https://bundler.io/) to manage gem installation.

```
$git clone https://github.com/dtrts/oystercard
$cd oystercard
$bundler
```

Gems used:
- `rspec`
- `rubocop`
- `simplecov-console`

Once the gems have been installed use `$rspec` to test the code. The output will also include test coverage thanks to `simplecov`.



## Usage

### IRB
To load irb with all the required files:

`$irb -r ./lib/oystercard.rb -r ./lib/journey_log.rb -r ./lib/journey.rb -r ./lib/station.rb`

### .rb script
To write your own script create a new ruby file in `/oystercard` and paste the following at the top
```
require_relative "./lib/oystercard.rb"
require_relative "./lib/journey_log.rb"
require_relative "./lib/journey.rb"
require_relative "./lib/station.rb"
```





## Focus Goals

***I write code that is easy to change***

Writing easy to change software is highly prized amongst developers and employers. By developers because most of a developer's time is spent changing software. By employers because their teams can deliver value to customers faster.

***I can test-drive my code***

Tested software is easier to change because you can tell when it's broken just by running a command, even the tricky edge cases.

***I can build with objects***

Most code in the world is structured in small pieces called objects. This is done because it is easier to change than having everything in one place.



---

## Files



```
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── coverage
├── design.md
├── feature_test
│   ├── 04_balance.rb
│   ├── 05_top_up.rb
│   ├── 06_maximum_balance.rb
│   ├── 07_deduct.rb
│   ├── 08_touch_in_out.rb
│   ├── 09_min_balance.rb
│   ├── 10_charge_on_touch_out.rb
│   ├── 11_saving_entry_station.rb
│   ├── 12_journey_history.rb
│   ├── 13_station_class.rb
│   ├── 14_journey_class.rb
│   ├── 15_journey_log.rb
│   ├── 16_fare_for_zones.rb
│   ├── eh.rb
│   └── feature_test1.rb
├── lib
│   ├── journey.rb
│   ├── journey_log.rb
│   ├── oystercard.rb
│   └── station.rb
└── spec
    ├── journey_log_spec.rb
    ├── journey_spec.rb
    ├── oystercard_spec.rb
    ├── spec_helper.rb
    └── station_spec.rb
```