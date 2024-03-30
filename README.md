GildedRose
=====

You will need to install [erlang](https://www.erlang.org/), and [rebar3](https://github.com/erlang/rebar3). I recommend following the instructions from JetBrains: [Getting Started with Erlang](https://www.jetbrains.com/help/idea/erlang.html).


Run Tests
---------

    $ rebar3 eunit --cover

Check code coverage
----------------

    $ rebar3 cover --verbose 

===> Verifying dependencies...
===> Analyzing applications...
===> Compiling gilded_rose
===> "/Users/vmihaylov/Desktop/Erlang/GildedRoseErlangKataSolution/_build/test/lib/gilded_rose/ebin/gilded_rose.app" is missing description entry
===> "/Users/vmihaylov/Desktop/Erlang/GildedRoseErlangKataSolution/_build/test/lib/gilded_rose/ebin/gilded_rose.app" is missing applications entry
===> Performing cover analysis...
  |------------------------|------------|
  |                module  |  coverage  |
  |------------------------|------------|
  |           gilded_rose  |      100%  |
  |                  main  |        0%  |
  |      texttest_fixture  |        0%  |
  |------------------------|------------|
  |                 total  |       74%  |

Line-by-line coverage report available at /_build/test/cover/index.html