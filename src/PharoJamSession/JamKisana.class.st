"
3-loops string instrument (based on Karplus-Strong) originally wrtiien by Yann Orlarey.

"
Class {
	#name : 'JamKisana',
	#superclass : 'JamInstrument',
	#category : 'PharoJamSession-Instrument',
	#package : 'PharoJamSession',
	#tag : 'Instrument'
}

{ #category : 'accessing' }
JamKisana >> code [ 

^ 'import("stdfaust.lib");
KEY = 60;	// basic midi key
NCY = 15; 	// note cycle length
CCY = 15;	// control cycle length
BPS = 480;	// general tempo (ba.beat per sec)

kisana = (harpe(C,11,48), harpe(C,11,60), (harpe(C,11,72) : *(1.5), *(1.5)) 
	:>*(l))
	with {
		l = -20 : ba.db2linear;//hslider("[1]Volume",-20, -60, 0, 0.01) : ba.db2linear;
		C = hslider("KisBrightness[acc:0 1 -10 0 10]", 0.2, 0, 1, 0.01) : ba.automat(BPS, CCY, 0.0);
	};

harpe(C,N,b) = 	hand(b) <: par(i, N, position(i+1)
							: string(C,Penta(b).degree2Hz(i), att, lvl)
							: pan((i+0.5)/N) )
				 	:> _,_
	with {
		att  = hslider("KisResonance[acc:2 1 -10 0 12]", 4, 0.1, 10, 0.01); 
		hand(48) = vslider("KisNote48[unit:pk][acc:1 0 -10 0 14]", 0, 0, N, 1) : int : ba.automat(120, CCY , 0.0);
		hand(60) = vslider("KisNote60[unit:pk][acc:1 0 -10 0 14]", 2, 0, N, 1) : int : ba.automat(240, CCY , 0.0);
		hand(72) = vslider("KisNote72[unit:pk][acc:1 0 -10 0 10]", 4, 0, N, 1) : int : ba.automat(980, CCY , 0.0);
		//lvl  = vslider("h:loop/level", 0, 0, 6, 1) : int : ba.automat(BPS, CCY, 0.0) : -(6) : ba.db2linear; 
		lvl = 1;
		pan(p) = _ <: *(sqrt(1-p)), *(sqrt(p));
		position(a,x) = abs(x - a) < 0.5;
	};


Penta(key) = environment {

	A4Hz = 440; 
	
	degree2midi(0) = key+0;
	degree2midi(1) = key+2;
	degree2midi(2) = key+4;
	degree2midi(3) = key+7;
	degree2midi(4) = key+9;
	degree2midi(d) = degree2midi(d-5)+12;
	
	degree2Hz(d) = A4Hz*semiton(degree2midi(d)-69) with { semiton(n) = 2.0^(n/12.0); };

}; 
 
//----------------------------------String-------------------------------
// A karplus-strong string.
//
// USAGE: string(440Hz, 4s, 1.0, button("play"))
// or	  button("play") : string(440Hz, 4s, 1.0)
//-----------------------------------------------------------------------

string(coef, freq, t60, level, trig) = no.noise*level
							: *(trig : trigger(freq2samples(freq)))
							: resonator(freq2samples(freq), att)
	with {
		resonator(d,a)	= (+ : @(d-1)) ~ (average : *(a));
		average(x)		= (x*(1+coef)+x''*(1-coef))/2;
		trigger(n) 		= upfront : + ~ decay(n) : >(0.0);
		upfront(x) 		= (x-x'') > 0.0;
		decay(n,x)		= x - (x>0.0)/n;
		freq2samples(f) = 44100.0/f;
		att 			= pow(0.001,1.0/(freq*t60)); // attenuation coefficient
		random  		= +(12345)~*(1103515245);
		noise   		= random/2147483647.0;
	};

    process = kisana;'.
]

{ #category : 'initialization' }
JamKisana >> initializeControlParameters [

	| bright n1 n2 n3 reso |
	super initializeControlParameters.

	bright := #KisBrightness -> (PhControlParameter new
		           label: #KisBrightness;
		           description: 'Instrument brightness';
		           min: 0;
		           max: 1;
		           step: 0.01;
		           value: 0.3;
		           widgetType: #horizontalsSlider).
	n1 := #KisNote48 -> (PhControlParameter new
		       label: #KisNote48;
		       description: 'First octave note value';
		       min: 0;
		       max: 11;
		       step: 1;
		       value: 0;
		       widgetType: #horizontalsSlider).
	n2 := #KisNote60 -> (PhControlParameter new
		       label: #KisNote60;
		       description: 'Second octave note value';
		       min: 0;
		       max: 11;
		       step: 1;
		       value: 0;
		       widgetType: #horizontalsSlider).
	n3 := #KisNote72 -> (PhControlParameter new
		       label: #KisNote72;
		       description: 'Third octave note value';
		       min: 0;
		       max: 11;
		       step: 1;
		       value: 0;
		       widgetType: #horizontalsSlider).
	reso := #KisResonance -> (PhControlParameter new
		         label: #res;
		         description: 'Filter resonance';
		         min: 0.1;
		         max: 10;
		         value: 3;
		         step: 0.01;
		         widgetType: #horizontalSlider).
	self controlParameters
		add: bright;
		add: n1;
		add: n2;
		add: n3;
		add: reso
]
