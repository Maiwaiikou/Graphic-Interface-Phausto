"
## Six Rack Tuned Bar
Based on Nonlinear Banded Waveguide Models;
 by Romain Michon (rmichon@ccrma.stanford.edu);
"
Class {
	#name : 'JamTuneBar6',
	#superclass : 'JamInstrument',
	#category : 'PharoJamSession-Instrument',
	#package : 'PharoJamSession',
	#tag : 'Instrument'
}

{ #category : 'accessing' }
JamTuneBar6 >> code [

	^ '
import("stdfaust.lib");
instrument = library("instruments.lib");

//==================== INSTRUMENT =======================

process = par(i, 6, onerack(i,i,i)):>_;

onerack(h,n,e) =  par(i, 5, tunedBar(h,i,e));

tunedBar(h,n,e) =
		((select-1)*-1) <:
		//nModes resonances with nModes feedbacks for bow table look-up 
		par(i,nModes,(resonance(i,freqqy(n,e),gate(h,n))~_)) :> + : 
		//Signal Scaling and stereo
		*(4);

//==================== GUI SPECIFICATION ================

gain = 0.8;
gate(h,n) = position(h,n) : upfront;
hand(0) = hslider("TB6Hand1", 0, 0, 5, 1):int:ba.automat(120, 15, 0.0);
hand(1) = hslider("TB6Hand2", 0, 0, 5, 1):int:ba.automat(120, 15, 0.0);
hand(2) = hslider("TB6Hand3", 2, 0, 5, 1):int:ba.automat(240, 15, 0.0);
hand(3) = hslider("TB6Hand4", 2, 0, 5, 1):int:ba.automat(240, 15, 0.0);
hand(4) = hslider("TB6Hand5", 4, 0, 5, 1):int:ba.automat(480, 15, 0.0);
hand(5) = hslider("TBHand6", 4, 0, 5, 1):int:ba.automat(480, 15, 0.0);

position(h,n) = abs(hand(h) - n) < 0.5;
upfront(x) = x>x'';

select = 1;
integrationConstant = 0;
baseGain = 1;

//----------------------- Frequency Table --------------------

freq(0) = 92.49;
freq(1) = 103.82;
freq(2) = 116.54;
freq(3) = 138.59;
freq(4) = 155.56;

freq(d)	 = freq(d-5)*2;
freqqy(d,e) = freq(d+e*5);
//==================== MODAL PARAMETERS ================

preset = 2;

nMode(2) = 4;

modes(2,0) = 1;
basegains(2,0) = pow(0.999,1);
excitation(2,0,g) = 1*gain*g/nMode(2);

modes(2,1) = 4.0198391420;
basegains(2,1) = pow(0.999,2);
excitation(2,1,g) = 1*gain*g/nMode(2);

modes(2,2) = 10.7184986595;
basegains(2,2) = pow(0.999,3);
excitation(2,2,g) = 1*gain*g/nMode(2);

modes(2,3) = 18.0697050938;
basegains(2,3) = pow(0.999,4);
excitation(2,3,g) = 1*gain*g/nMode(2);

//==================== SIGNAL PROCESSING ================

//----------------------- Nonlinear filter ----------------------------
//nonlinearities are created by the nonlinear passive allpass ladder filter declared in filter.lib

//nonlinear filter order
nlfOrder = 6; 

//----------------------- Synthesis parameters computing and functions declaration ----------------------------

//the number of modes depends on the preset being used
nModes = nMode(preset);

delayLengthBase(f) = ma.SR/f;

//delay lengths in number of samples
delayLength(x,f) = delayLengthBase(f)/modes(preset,x);

//delay lines
delayLine(x,f) = de.delay(4096,delayLength(x,f));

//Filter bank: fi.bandpass filters (declared in instrument.lib)
radius = 1 - ma.PI*32/ma.SR;
bandPassFilter(x,f) = instrument.bandPass(f*modes(preset,x),radius);

//----------------------- Algorithm implementation ----------------------------

//One resonance
resonance(x,f,g) = + : + (excitation(preset,x,g)*select) : delayLine(x,f) : *(basegains(preset,x)) : bandPassFilter(x,f);

'
]

{ #category : 'initialization' }
JamTuneBar6 >> initializeControlParameters [

	| hand1 hand2 hand3 hand4 hand5 hand6 |
	super initializeControlParameters.


	hand1 := #TB6Hand1 -> (PhControlParameter new
		         label: #TB6Hand1;
		         description: 'First note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		hand2 := #TB6Hand2 -> (PhControlParameter new
		         label: #TB6Hand2;
		         description: 'Second note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		hand3 := #TB6Hand3 -> (PhControlParameter new
		         label: #TB6Hand3;
		         description: 'Third note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		hand4 := #TB6Hand4 -> (PhControlParameter new
		         label: #TB6Hand4;
		         description: 'Fourth note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		hand5 := #TB6Hand5 -> (PhControlParameter new
		         label: #TB6Hand5;
		         description: 'Fifth note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		hand6 := #TB6Hand6 -> (PhControlParameter new
		         label: #TB6Hand6;
		         description: 'Sixth note';
		         min: 0;
		         max: 5;
		         step: 1;
		         value: 0;
		         widgetType: #horizontalsSlider).
		
		


	self controlParameters
		add: hand1;
		add: hand2;
		add: hand3; add: hand4 ; add: hand5; add: hand6.
]
