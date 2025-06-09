"
Simple echo effect with controls for delay time and intensity
"
Class {
	#name : 'JamEchoDelay',
	#superclass : 'JamEffect',
	#category : 'PharoJamSession-Effect',
	#package : 'PharoJamSession',
	#tag : 'Effect'
}

{ #category : 'accessing' }
JamEchoDelay >> code [ 
^ '
import("stdfaust.lib");

/* ============ DESCRIPTION =============

- Variable de.delay echo
- Echo Delay = Pick manually which amount of time in seconds must be repeated by the echo
- Rocking = To vary the intensity of the echo

*/

process = echo;

echo = +~ @(echoDelay)*(feedback);

echoDelay = hslider("EchoDelay", 0.5, 0.01, 1, 0.001):min(1):max(0.01)*(44100):int;
feedback = hslider("EchoIntensity", 0.001, 0.001, 0.65, 0.001):si.smooth(0.999);'
]

{ #category : 'initialization' }
JamEchoDelay >> initializeControlParameters [

	| delay  intensity |
	super initializeControlParameters.


	delay := #EchoDelay -> (PhControlParameter new
		         label: #EchoDelay;
		         description: 'Delay Time in seconds';
		         min: 0.1;
		         max: 1;
		         step: 0.01;
		         value: 0.3;
		         widgetType: #horizontalsSlider).

	intensity := #EchoIntensity -> (PhControlParameter new
		          label: #EchoIntensity;
		          description: 'Delay intensity';
		          min: 0;
		          max: 11;
		          step: 1;
		          value: 0;
		          widgetType: #horizontalsSlider).
	
	self controlParameters
		add: delay;
		add: intensity .
]
