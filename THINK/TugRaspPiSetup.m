function [robotPi,rudderServo,propServo, blinkLED, cam] = TugRaspPiSetup()
%  TUGRASPPISETUP This function creates a Raspberry Pi object and configures the Raspberry Pi 
% to work with the Think Labs robot tug boat sensors and servos. 
% 
% It has no input arguments and returns a set of Pi objects to be used by supporting 
% Sensor and Actuator functions. This function must be run first, before its Robot 
% Tugboat famly functions will run.
% 
% D. Barrett Jan 2021  Revision A
% SETUP_Pi creates and configures a Raspberry  Pi to be a simple robot 
% controller. It requires no inputs and returns an Pi and Servo Pi objects
% D. Barrett 2021 Rev A
% Create a global raspberry PI object so that it can be used in functions
% Create a *raspi* object.
   robotPi = raspi();
 
% There is a user LED on Raspberry Pi hardware that you can turn on and
% off. Execute the following command at the MATLAB prompt to turn the LED
% off and then turn it on again.
%
   blinkLED = robotPi.AvailableLEDs{1};
   
% Note: use webcam function instead if using a USB camera
    %cam = cameraboard(robotPi,'Resolution','1280x720');
    cam = 0;
    
% create servo objectd driving PWM GPIO pin 4 and pin 5
% MinPulseDuration: 1120 (microseconds)  center 1520 (microseconds)
% MaxPulseDuration: 1920 (microseconds)
% servo(mypi, pinNumber, Name,Value) creates a servo motor object 
% with additional options specified by one or more Name, Value pair arg
  rudderServo = servo(robotPi, 4, 'MaxPulseDuration', 1925*10^-6, ...
      'MinPulseDuration', 1120*10^-6); 
  propServo = servo(robotPi, 5, 'MaxPulseDuration', 1925*10^-6, ...
      'MinPulseDuration', 1120*10^-6);   
  
% R-C Mode expects to start up with joystick centered
% In the RasPI MATLAB function servo position is 0-180 so 90 (1520ms) is centered
  writePosition(rudderServo, 90); % always start servo-command at center
  writePosition(propServo, 90); % always start servo-command at center
  pause(5.0);                   % wait for Pi to send stable pwm
end