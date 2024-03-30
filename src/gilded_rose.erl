-module(gilded_rose).
-import(string,[left/2]). 

-include("gilded_rose.hrl").

-export([
  update_quality/1
]).

-spec update_quality([#item{}]) -> [#item{}].
update_quality(Items) ->
  lists:map(fun update_item/1, Items).

-spec increase_quality(#item{}, boolean()) -> #item{}.
increase_quality(Item = #item{quality = Quality}, IsConjured) when IsConjured == true andalso Quality =< 48 -> 
  Item#item{quality = Item#item.quality + 2};

increase_quality(Item = #item{quality = Quality}, IsConjured) when IsConjured == false andalso Quality =< 49 -> 
  Item#item{quality = Item#item.quality + 1};

increase_quality(Item = #item{quality = Quality}, _IsConjured) when Quality == 49 -> 
  Item#item{quality = Item#item.quality + 1};

increase_quality(Item = #item{quality = Quality}, _IsConjured) when Quality >= 50 -> 
  Item.

-spec decrease_quality(#item{}, boolean()) -> #item{}.
decrease_quality(Item = #item{quality = Quality}, IsConjured) when IsConjured == true andalso Quality >= 2 -> 
  Item#item{quality = Item#item.quality - 2};

decrease_quality(Item = #item{quality = Quality}, IsConjured) when IsConjured == false andalso Quality >= 1 -> 
  Item#item{quality = Item#item.quality - 1};

decrease_quality(Item = #item{quality = Quality}, _IsConjured) when Quality == 1 -> 
  Item#item{quality = Item#item.quality - 1};

decrease_quality(Item = #item{quality = Quality}, _IsConjured) when Quality =< 0 -> 
  Item.

-spec decrease_sell_in(#item{}) -> #item{}.
decrease_sell_in(Item) -> 
  Item#item{sell_in = Item#item.sell_in - 1}.

-spec update_aged_brie(#item{}, boolean()) -> #item{}.
update_aged_brie(Item, IsConjured) ->
  Item1 = increase_quality(Item, IsConjured),
  Item2 = decrease_sell_in(Item1),
  if
    Item2#item.sell_in < 0 ->
      increase_quality(Item2, IsConjured);
    true ->
      Item2
  end.

-spec update_backstage_passes(#item{}, boolean()) -> #item{}.
update_backstage_passes(Item, IsConjured) ->
  Item1 = increase_quality(Item, IsConjured),
  Item2 = if
            Item1#item.sell_in < 11 ->
              increase_quality(Item1, IsConjured);
            true ->
              Item1
          end,
  Item3 = if
            Item2#item.sell_in < 6 ->
              increase_quality(Item2, IsConjured);
            true ->
              Item2
          end,
  Item4 = decrease_sell_in(Item3),
  if
    Item4#item.sell_in < 0 ->
      Item4#item{quality = 0};
    true -> 
      Item4
  end.

-spec update_sulfuras_hand_of_ragnaros(#item{}) -> #item{}.
update_sulfuras_hand_of_ragnaros(Item) ->
  Item.

  -spec update_another_item(#item{}, boolean()) -> #item{}.
update_another_item(Item, IsConjured) ->
  Item1 = decrease_quality(Item, IsConjured),
  Item2 = decrease_sell_in(Item1),
  if
    Item2#item.sell_in < 0 ->
      decrease_quality(Item2, IsConjured);
    true -> 
      Item2
  end.

-spec update_item(#item{}) -> #item{}.
update_item(Item = #item{name = Name})  ->
  Left8CharsOfName = string:left(Name, 8),
  IsConjured = if
                 Left8CharsOfName == "Conjured" ->
                   true;
                 true ->
                   false
                 end,
  NameWithoutConjured = if
                          IsConjured ->
                            string:slice(Name, 9);
                          true ->
                            Name
                          end,
  case NameWithoutConjured of
    "Aged Brie" ->
      update_aged_brie(Item, IsConjured);
    "Backstage passes to a TAFKAL80ETC concert" ->
      update_backstage_passes(Item, IsConjured);
    "Sulfuras, Hand of Ragnaros" ->
      update_sulfuras_hand_of_ragnaros(Item);
    _Else ->
      update_another_item(Item, IsConjured)
  end.


