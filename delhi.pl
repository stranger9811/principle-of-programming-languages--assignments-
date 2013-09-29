%% Assignment 1: Delhi Metro
%% Due on: 30 Sep 2013 (Monday) before midnight.

%% Please fill the following details
%% Full Name:
%% Roll No:

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

printPath(X,Y) :- line(Z,P),member(X,P),member(Y,P),write('From '),write(X),write(' take '),write(Z),write(' line to '),write(Y),write('\n').
findRoute1(X,Y,CoveredLines) :- line(Z,P),member(X,P),member(Y,P).
findRoute1(X,Y,CoveredLines) :- line(A,P),member(X,P),not(member(A,CoveredLines)),line(B,P2),member(Z,P),member(Z,P2),findRoute1(Z,Y,[ A | CoveredLines ]),printPath(X,Z),printPath(Z,Y).
findRoute(X,Y) :- (line(Z,P),member(X,P),member(Y,P) -> printPath(X,Y);findRoute1(X,Y,[])).
