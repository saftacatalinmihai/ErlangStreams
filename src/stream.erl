%%%-------------------------------------------------------------------
%%% @author casafta
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jun 2016 16:15
%%%-------------------------------------------------------------------
-module(stream).
-author("casafta").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([defer/1, defer/2, defer/3, defer/4, repeat/1, integers/0, from/1, fromF/2, fromF/3, tail/1, take/2, takeWhile/2, map/2, filter/2]).

defer(F, A1, A2, A3) -> fun() -> F(A1, A2, A3) end.
defer(F, A1, A2) -> fun() -> F(A1, A2) end.
defer(F, Args) -> fun() -> F(Args) end.
defer(F) -> fun() -> F() end.

repeat(I) ->
  [I | defer( fun repeat/1, I )].

integers() -> from(1).

from (I) -> fromF (I, fun(X) -> X + 1 end ).

fromF(A, Fun) ->
  [A | defer (fun fromF/2, Fun(A), Fun)].

fromF(A1, A2, Fun) ->
  [A1 | defer (fun fromF/3, A2, Fun(A1, A2), Fun)].

take(1, [H|_]) -> [H];
take(_, []) -> [];
take(N, [H| Next]) ->
  [H | take(N-1, Next())].

map(F, [H| Next]) ->
  [F(H) | defer( fun map/2, F, Next() )].

filter(Pred, [H| Next]) ->
  case Pred(H) of
    true -> [H | defer( fun filter/2, Pred, Next() ) ];
    false -> filter(Pred, Next())
  end.

takeWhile(Pred, Stream) -> lists:reverse(takeWhile(Pred, Stream, [])).
takeWhile(Pred,Stream, Acc) ->
  [H|Next] = Stream,
  case Pred(H) of
    true -> takeWhile(Pred, Next(), [H | Acc]);
    false -> Acc
  end.

tail([_|Next]) -> Next().

