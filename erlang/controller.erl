%% Assignment 2: Traffic lights
%% Due on: To be decided.

%% Please fill the following details
%% Full Name: Ashok Kumar
%% Roll No: 11164


%% In this assignment you have to design a controller that will
%% control the traffic at a pedestrian crossing on a busy highway
%% using two traffic lights. These traffic lights are simple 2-state
%% traffic light, and an implementation is given in the module signal:

%% http://github.com/piyush-kurur/sample-code/blob/assignment/assignments/traffic/signal.erl

%% One of the traffic signal controls the flow of vehicles and the
%% other allows/disallows the pedestrians from crossing.
%%
%% Implement the controller using the erlang function

%%      controller(TraffiPid,PedestrianPid,State)

%%
%% The rules of pedestrian crossing is the following:
%%
%% 1. At no point of time should both the signals be green. Both can
%%    however be red (see rules 5 and 6 below).
%%
%% 2. The traffic light for vehicles will be green by default and
%%    should only turn red on request from a pedestrian subject to the
%%    condition that there is a minimum gap of at least 10minutes
%%    between two consecutive red lights.
%%
%% 3. The pedestrian can request for a stop of traffic by pressing a
%%    stop button. This will send the message 'stop' to the controller.
%%
%% 4. The pedestrian signal should remain green for 5min at a stretch.
%%    during which all requests for stop should be ignored (the
%%    crossing is already green).
%%
%% 5. To allow the last pedestrian to cross the road safely make sure
%%    that the highway signal becomes green only after 2min of the
%%    pedestrian signal becoming red.
%%
%% 6. Similarly to allow the last vehicle to cross the junction, make
%%    sure that the pedestrian signal becomes green only after 1min of
%%    the traffic signal becoming red.

-module(controller).
-import(timer,[send_after/3]).
-export([control/3,stop/1,start/2]).

stop(ControllerPid) ->
	ControllerPid ! {self(),stop}.

start(TrafficPid,PedestrianPid) ->
    spawn(fun () -> control(TrafficPid,PedestrianPid,0) end).


control(TrafficPid,PedestrianPid,State) ->
	receive
		{Pid, ask} ->
	    	TrafficPid ! {Pid,ask},
	    	control(TrafficPid,PedestrianPid,State);
	    {NewPid,unlock} ->
	    	if NewPid =:= self() ->
	    		control(TrafficPid,PedestrianPid,0)
	    	end;	
	 	{Pid,pedestrian,green} ->
	 		PedestrianPid ! {Pid,green},
	 		send_after(3000,self(),{Pid,pedestrian,red}),
	 		control(TrafficPid,PedestrianPid,1);
	 	{Pid,pedestrian,red} ->
	 		PedestrianPid ! {Pid,red},
	 		send_after(2000,self(),{Pid,traffic,green}),
	 		control(TrafficPid,PedestrianPid,1);
	 	{Pid,traffic,green} ->
	 		TrafficPid ! {Pid,green},
	 		control(TrafficPid,PedestrianPid,1);
	 	{TrafficPid,red} ->
	 		io:format("Already red ~n"),
	 		control(TrafficPid,PedestrianPid,State);
	 	{TrafficPid,green} ->
	 		io:format("state can't be changed ~n"),
	 		control(TrafficPid,PedestrianPid,State);
	 	{Pid, stop} ->
	 		if State =:= 0 ->
	 			TrafficPid ! {Pid,red},
	 			send_after(20000,self(),{self(),unlock}),
	 			send_after(2000,self(),{Pid,pedestrian,green}),
	 			control(TrafficPid,PedestrianPid,1);
	 			State =:= 1 ->
	 				TrafficPid ! {self(),ask},
	 				control(TrafficPid,PedestrianPid,State)
	 		end	
    end,
    control(TrafficPid,PedestrianPid,State).

