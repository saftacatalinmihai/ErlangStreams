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
    stream:takeWhile( fun (X)-> X =< 99 end, OddIntegers)
  ),

  SquareIntegers = stream:map(fun (X) -> X * X end, Integers),
  ?assertEqual(
    lists:map(fun (X) -> X * X end, lists:seq(1,99)),
    stream:take(99, SquareIntegers)
  ).

fib_test() ->
  Sum2 = fun(A, B) -> A + B end,
  Fibs = stream:fromF(1,1, Sum2),
  ?assertEqual([1,1,2,3,5,8,13], stream:take(7, Fibs)).

