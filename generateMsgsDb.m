function generateMsgsDb()


    % Access the database file.
    db = canDatabase('GEN4.dbc');

    % Create the messages to send using the canMessage function.
    %msgTxSunroof = canMessage(db, 'SunroofControlMsg'); 
    %msgTxWindows = canMessage(db, 'WindowControlMsg');
    %msgTxDoors = canMessage(db, 'DoorControlMsg');
    %msgTxTrans = canMessage(db, 'TransmissionMsg');
    %msgTxEngine = canMessage(db, 'EngineMsg');

    msgACInfo = canMessage(db,"B2VST2");

    % Create a CAN channel on which to transmit.
    txCh = canChannel("MathWorks" ,"Virtual 1" , 1,'ProtocolMode','CAN');

    % Register each message on the channel at a specified periodic rate.
    %transmitPeriodic(txCh, msgTxSunroof, 'On', 0.500);
    %transmitPeriodic(txCh, msgTxWindows, 'On', 0.250);
    %transmitPeriodic(txCh, msgTxDoors, 'On', 0.125);
    %transmitPeriodic(txCh, msgTxTrans, 'On', 0.050);
    %transmitPeriodic(txCh, msgTxEngine, 'On', 0.025);
    
    transmitPeriodic(txCh, msgACInfo, 'On', 0.025);
    % Start the CAN channel.
    start(txCh);
    %msgACInfo.Signals.B2VST2FaultCode=rand*2550;
    %msgACInfo.Signals.B2VST2SOC=rand;
    % Run for several seconds incrementing the message data regularly.
    for ii = 1:50
        % Set new signal data.
        %msgTxSunroof.Signals.OpenState = 1;
        %msgTxWindows.Signals.DriverDoorWindow = 60 + (rand * 10);
        %msgTxWindows.Signals.PassengerDoorWindow = 60 + (rand * 10);
        %msgTxDoors.Signals.PassengerDoorLock = rand;
        %msgTxDoors.Signals.DriverDoorLock = rand;
        %msgTxTrans.Signals.Gear = 4 + rand;
        %msgTxEngine.Signals.VehicleSpeed =msgTxEngine.Signals.VehicleSpeed+ 1 ;
        %msgTxEngine.Signals.EngineRPM = 3500 + (rand * 250);
        msgACInfo.Signals.B2VST2PackCurrent=msgACInfo.Signals.B2VST2PackCurrent+1;
        msgACInfo.Signals.B2VST2FaultCode=rand*2550;
        msgACInfo.Signals.B2VST2SOC=rand;

        % Wait for a time period.
        pause(0.01);
    end

    % Stop the CAN channel.
    stop(txCh);
end
