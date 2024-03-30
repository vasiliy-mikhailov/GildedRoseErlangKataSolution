-module(gilded_rose_test).

-include_lib("eunit/include/eunit.hrl").

-include("gilded_rose.hrl").

quality_of_foo_decreases_by_one_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Foo", sell_in = 1, quality = 2}]),
  Expected = [#item{name= "Foo", sell_in = 0, quality = 1}],
  ?assertEqual(Expected, Actual).

quality_of_sulfuras_hand_of_ragnaros_never_decreases_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Sulfuras, Hand of Ragnaros", sell_in = 1, quality = 2}]),
  Expected = [#item{name= "Sulfuras, Hand of Ragnaros", sell_in = 1, quality = 2}],
  ?assertEqual(Expected, Actual).

sulfuras_hand_of_ragnaros_never_gets_sold_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Sulfuras, Hand of Ragnaros", sell_in = 0, quality = 2}]),
  Expected = [#item{name= "Sulfuras, Hand of Ragnaros", sell_in = 0, quality = 2}],
  ?assertEqual(Expected, Actual).

quality_of_sulfuras_hand_of_ragnaros_never_decreases_and_it_never_gets_sold_on_negative_sell_in_and_negative_quality_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Sulfuras, Hand of Ragnaros", sell_in = -1, quality = -1}]),
  Expected = [#item{name= "Sulfuras, Hand of Ragnaros", sell_in = -1, quality = -1}],
  ?assertEqual(Expected, Actual).
  
quality_of_sulfuras_hand_of_ragnaros_never_decreases_and_it_never_gets_sold_on_negative_sell_in_and_positive_quality_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Sulfuras, Hand of Ragnaros", sell_in = -1, quality = 1}]),
  Expected = [#item{name= "Sulfuras, Hand of Ragnaros", sell_in = -1, quality = 1}],
  ?assertEqual(Expected, Actual).
    
quality_of_an_item_never_drops_below_zero_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Item", sell_in = 1, quality = 0}]),
  Expected = [#item{name= "Item", sell_in = 0, quality = 0}],
  ?assertEqual(Expected, Actual).

quality_of_aged_brie_increases_the_older_it_gets_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Aged Brie", sell_in = 1, quality = 2}]),
  Expected = [#item{name= "Aged Brie", sell_in = 0, quality = 3}],
  ?assertEqual(Expected, Actual).

quality_of_aged_brie_is_never_more_than_fifty_when_positive_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Aged Brie", sell_in = 1, quality = 50}]),
  Expected = [#item{name= "Aged Brie", sell_in = 0, quality = 50}],
  ?assertEqual(Expected, Actual).

quality_of_aged_brie_is_never_more_than_fifty_when_negative_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Aged Brie", sell_in = -1, quality = 50}]),
  Expected = [#item{name= "Aged Brie", sell_in = -2, quality = 50}],
  ?assertEqual(Expected, Actual).

quality_of_backstage_passes_is_never_more_than_fifty_when_quality_is_49_and_sell_in_is_less_than_6_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 49}]),
  Expected = [#item{name= "Backstage passes to a TAFKAL80ETC concert", sell_in = 4, quality = 50}],
  ?assertEqual(Expected, Actual).

once_the_sell_by_date_has_passed_quality_of_aged_brie_degrades_twice_as_fast_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Aged Brie", sell_in = 0, quality = 40}]),
  Expected = [#item{name= "Aged Brie", sell_in = -1, quality = 42}],
  ?assertEqual(Expected, Actual).

once_the_sell_by_date_has_passed_quality_of_an_item_degrades_twice_as_fast_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Item", sell_in = 0, quality = 40}]),
  Expected = [#item{name= "Item", sell_in = -1, quality = 38}],
  ?assertEqual(Expected, Actual).

quality_of_backstage_passes_increases_by_1_when_there_are_11_days_or_more_in_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 11, quality = 49}]),
  Expected = [#item{name= "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 50}],
  ?assertEqual(Expected, Actual).

quality_of_backstage_passes_increases_by_2_when_there_are_10_days_or_less_in_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 10}]),
  Expected = [#item{name= "Backstage passes to a TAFKAL80ETC concert", sell_in = 9, quality = 12}],
  ?assertEqual(Expected, Actual).

quality_of_backstage_passes_increases_by_3_when_there_are_5_days_or_less_in_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 10}]),
  Expected = [#item{name= "Backstage passes to a TAFKAL80ETC concert", sell_in = 4, quality = 13}],
  ?assertEqual(Expected, Actual).

quality_of_backstage_passes_drops_to_zero_after_concert_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 0, quality = 10}]),
  Expected = [#item{name= "Backstage passes to a TAFKAL80ETC concert", sell_in = -1, quality = 0}],
  ?assertEqual(Expected, Actual).

quality_of_conjured_aged_brie_increases_twice_as_fast_the_older_it_gets_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Aged Brie", sell_in = 1, quality = 2}]),
  Expected = [#item{name= "Conjured Aged Brie", sell_in = 0, quality = 4}],
  ?assertEqual(Expected, Actual).


quality_of_conjured_aged_brie_increases_twice_as_fast_the_older_it_gets_with_quality_equals_49_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Aged Brie", sell_in = 1, quality = 49}]),
  Expected = [#item{name= "Conjured Aged Brie", sell_in = 0, quality = 50}],
  ?assertEqual(Expected, Actual).

quality_of_conjured_sulfuras_hand_of_ragnaros_never_decreases_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Sulfuras, Hand of Ragnaros", sell_in = 1, quality = 1}]),
  Expected = [#item{name= "Conjured Sulfuras, Hand of Ragnaros", sell_in = 1, quality = 1}],
  ?assertEqual(Expected, Actual).


quality_of_conjured_backstage_passes_increases_by_4_when_there_are_10_days_or_less_in_sell_in_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 10}]),
  Expected = [#item{name= "Conjured Backstage passes to a TAFKAL80ETC concert", sell_in = 9, quality = 14}],
  ?assertEqual(Expected, Actual).

quality_of_conjured_item_decreases_by_two_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Foo", sell_in = 1, quality = 20}]),
  Expected = [#item{name= "Conjured Foo", sell_in = 0, quality = 18}],
  ?assertEqual(Expected, Actual).

quality_of_conjured_item_with_quality_one_decreases_by_one_test() ->
  Actual = gilded_rose:update_quality([#item{name = "Conjured Foo", sell_in = 1, quality = 1}]),
  Expected = [#item{name= "Conjured Foo", sell_in = 0, quality = 0}],
  ?assertEqual(Expected, Actual).