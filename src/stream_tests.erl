%%%-------------------------------------------------------------------
%%% @author casafta
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jun 2016 16:16
%%%-------------------------------------------------------------------
-module(stream_tests).
-author("casafta").
-include_lib("eunit/include/eunit.hrl").

integers_test() ->
  Integers =  stream:integers(),
  ?assertEqual(lists:seq(1,99), stream:take(99,Integers)),

  OddIntegers = stream:filter(fun(X) -> X rem 2 =:= 0 end, Integers),
  ?assertEqual(
    lists:filter(fun(X) -> X rem 2 =:= 0 end, lists:seq(1,99)),
    stream:take(49,OddIntegers)
  ).


fib_test() ->
  Fibs = stream:fromF(1,1, fun(I,J) -> I + J  end ),
  ?assertEqual([1,1,2,3,5,8,13], stream:take(7, Fibs)).

