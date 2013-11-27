%
% A simple traffic signal light that consists of two states, red and
% green. The controller is supposed to use two such lights.
%



-module(signal).
-export([send_mesg/2,switch_state/3,signal_light/1,startVechile/0,startPedestrain/0]).

send_mesg(Pid,Message) ->
    Pid ! {self(), Message}.

switch_state(Pid, State, NewState) ->
    case NewState of
	red   ->
	    send_mesg(Pid, 'now red'),
	    signal_light(red);
	green ->
	    send_mesg(Pid, 'now green'),
	    signal_light(green);
	error ->
	    send_mesg(Pid,{'unknown new state', NewState}),
	    signal_light(State)
    end.

startVechile() ->
    spawn(fun () -> signal_light(green) end).

startPedestrain() ->
    spawn(fun () -> signal_light(red) end).


signal_light(State) ->
    receive
	{Pid, ask} ->
	    send_mesg(Pid,State),
	    signal_light(State);
	{Pid, NewState} ->
	    switch_state(Pid, State, NewState);
	error ->
	    signal_light(State)
    end.