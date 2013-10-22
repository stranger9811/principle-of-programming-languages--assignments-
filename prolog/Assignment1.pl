%% Assignment 1: Delhi Metro
%% Due on: 30 Sep 2013 (Monday) before midnight.

%% Please fill the following details
%% Full Name: Ashok Kumar	
%% Roll No:   11164

%% Given below is the metro lines of New Delhi. Write a function
%% that given any two metro station prints out the route to take

%% For example typing
%%     > findRoute(dwarka,new-delhi).
%% should print
%%     > From dwarka take blue line to rajiv-chowk
%%     > From rajiv-chowk take yellow line to new-delhi

%% Concepts not done in class: Formated print, List functions.
%%

%% Remark: You code *should work* work even if the lines are changed.
%% In particular you should not assume anything about the names of the
%% station, or their ordering or the topology of the network. In other
%% words think of this red, blue and green line as a sample input to your
%% program.


line(red,
[ rithala,
          rohini-east,
          rohini-west,
          pitam-pura,
          kohat-enclave,
          netaji-subash-place,
          keshav-puram,
          kanhaiya-nagar,
          indralok,
          shastri-nagar,
          pratap-nagar,
          pul-bangesh,
          tiz-hazari,
          kashmiri-gate,
          shastri-park,
          seelam-pur,
          welcome,
          shahdara,
          mansarovar-park,
          jhilmil,
          dilshad-garden
        ]
    ).
line(yellow,[ vishwa-vidayala
            , vidhan-sabha
            , civil-lines
            , kashmiri-gate
            , chandini-chowk
            , chawari-bazar
            , new-delhi
            , rajiv-chowk
            , patel-chowk
            , central-secretariat
            ]
    ).

line(blue,[ indraprastha
          , pragati-maidan
          , mandi-house
          , barakhamba-road
          , rajiv-chowk
          , ramakrishna-ashram-marg
          , jhandewala
          , karol-bagh
          , rajendra-place
          , patel-nagar
          , shadipur
          , kirti-nagar
          , moti-nagar
          , ramesh-nagar
          , rajouri-garden
          , tagore-garden
          , subhash-nagar
          , tilak-nagar
          , janakpuri-east
          , janakpuri-west
          , uttam-nagar-east
          , uttam-nagar-west
          , nawada
          , dwarka-mor
          , dwarka
          , sector-14-dwarka
          , sector-13-dwarka
          , sector-12-dwarka
          , sector-11-dwarka
          , sector-10-dwarka
          , sector-9-dwarka
          ]).


printLine([X,Y,Z | _]) :- write('From '),write(X),write(' take '),write(Y),write(' line to '),write(Z),write('\n').
printRoute([]) :- write('\n').
printRoute([ Head | Tail ]) :- printLine(Head),printRoute(Tail).

findRoute1(X,X,_,_) :- write('You are at same node \n').
findRoute1(X,Y,_,RecordRoute) :- line(Z,P),member(X,P),member(Y,P),reverse([[X,Z,Y] | RecordRoute],B),printRoute(B).
findRoute1(X,Y,CoveredLines,RecordRoute) :- line(A,P),line(B,P2),not(A==B),member(X,P),not(member(A,CoveredLines)),member(Z,P),not(Z==X),member(Z,P2),findRoute1(Z,Y,[ A | CoveredLines ],[[X,A,Z] | RecordRoute ]).
findRoute(X,Y) :- findRoute1(X,Y,[],[]).
