c(signal).        // to compile signal.erl
P1 = signal:startVechile().        // to store pid of traffic light. This will create a thread Traffic light

P2 = signal:startPedestrain().    // to start Pedestrain thread and P2 will store pid of that thread

Cont = controller:start(P1,P2).   // to start controller thread and Cont will store pid of controller

now we can send stop message to controller using
controller:stop(Cont).
