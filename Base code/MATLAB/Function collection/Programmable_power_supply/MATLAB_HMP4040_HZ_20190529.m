% Make sure you have installed NI VISA 15.0 or newer
% This example does not require MATLAB Instrument Control Toolbox
% It is based on taking advantage of using .NET assembly called Ivi.Visa
% that is istalled together with NI VISA 15.0 or newer

% this code uses the functions from VISA_Instrument class, combining with
% the direct SCPI command

% type "help VISA_Instrument" to get help on VISA_Instrument class

% This code is mainly for remote control the power supply HMP4040 via USB-COM Port. Main
% functions include (1)Channel selection, (2)Voltage setting, (3)Current setting,
% (4)Combined setting of voltage and current, and (5)Output setting

%-----------------------------------------------------------
% Initialization
%-----------------------------------------------------------

try
    specan = VISA_Instrument('COM8'); % Adjust the VISA Resource string to fit into the instrument
                                      % set to USB-COM Port
    specan.SetTimeoutMilliseconds(3000); % Timeout for VISA Read Operations
    % specan.AddLFtoWriteEnd = false;
catch ME
    error ('Error initializing the instrument:\n%s', ME.message);
    % Error message of initialization of the remote control
end

%-----------------------------------------------------------
% Operations
%-----------------------------------------------------------

try
specan.Write('SYST:DISP:UPD ON'); % Display update ON - switch OFF after debugging

specan.Write('INST OUT2'); % Channel selection: selects a seperate channel for configuration
%specan.Write('VOLT 2'); % Voltage setting: sets the voltage value of the selected channel 
%specan.Write('CURR 0.1'); % Current setting: sets the current value of the selected channel 
specan.Write('APPLY 10,4'); % Combined setting: sets the voltage and current value of the selected channel 
specan.Write('OUTP:SEL ON'); % Output setting: activates or deactivates the previous selected channel
% -----------------------------------------------------------
% Closing the session
% -----------------------------------------------------------
specan.Close() % Closing the session to the instrument
 
catch ME
end




