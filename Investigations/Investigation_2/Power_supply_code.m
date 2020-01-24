%created by Aman Pishu Ganglani 
%inputs = specan, voltage, current, channel, output(0 or 1)
%note: local specan command must be run for the first time to successfuly
%handshake with the power supply 

function[] = Power_supply_code(specan, channel, voltage, current, output) 
%part below will build the strings correctly so that it works with the power supply 
channel_select = ['INST OUT' int2str(channel)];
voltage = ['VOLT ' int2str(voltage)];
current = ['CURR ' int2str(current)];
output = ['OUTP:STAT ' int2str(output)];

%specan = VISA_Instrument('COM8'); % Adjust the VISA Resource string to fit into the instrument
%send out commands requested 
% specan.Write("SYST:DISP:UPD ON"); % Display update ON - switch OFF after debugging
specan.Write(channel_select); % Channel selection: selects a seperate channel for configuration
specan.Write(voltage); % Voltage setting: sets the voltage value of the selected channel 
specan.Write(current); % Current setting: sets the current value of the selected channel 
specan.Write('OUTP:SEL 1'); % Output setting: activates or deactivates the previous selected channel, just leave this on every time since state will decide if it's on or off anyway
specan.Write(output); % Output state which switches it on or off 
end







