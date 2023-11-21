db = canDatabase("GEN4.dbc")

rxCh = canChannel("MathWorks" ,"Virtual 1" , 2, 'ProtocolMode','CAN');
rxCh.Database = db  % create the channel and coonect it to the database
start(rxCh);
generateMsgsDb();
stop(rxCh); 
rxMsg = receive(rxCh, Inf, "OutputFormat", "timetable");
clear rxCh;
signalTimetable=canSignalTimetable(rxMsg,'B2VST2');
%write the signal to a mdf file
mdfWrite("TimetableBasic.mf4",signalTimetable);
tiledlayout(3,1)
nexttile;
plot(signalTimetable.Time,signalTimetable.B2VST2PackCurrent);
title("B2V Pack Current", "FontWeight", "bold");
xlabel("Timestamp");
ylabel("Current");
ax2=nexttile;
scatter(signalTimetable.Time,signalTimetable.B2VST2FaultCode);
title("Fault", "FontWeight", "bold");
xlabel("Timestamp");
ylabel("Fault Code");
grid(ax2,'on');
nexttile;
plot(signalTimetable.Time,signalTimetable.B2VST2SOC);
title("SOC Level", "FontWeight", "bold");
xlabel("Timestamp");
ylabel("SOC");