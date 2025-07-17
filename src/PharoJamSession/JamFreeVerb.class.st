"
FreeVerb Mono with just simplified controls
"
Class {
	#name : 'JamFreeVerb',
	#superclass : 'JamEffect',
	#instVars : [
		'decayTime',
		'input'
	],
	#category : 'PharoJamSession-Effect',
	#package : 'PharoJamSession',
	#tag : 'Effect'
}

{ #category : 'initialization' }
JamFreeVerb >> asBox [

	^ (FreeverbMono new
		  fb1: self decayTime;
		  fb2: self decayTime;
		  input: self input) asBox
]

{ #category : 'accessing' }
JamFreeVerb >> decayTime [

^ decayTime
]

{ #category : 'initialization' }
JamFreeVerb >> initialize [

	super initialize.
	numberOfInputs := 1.
	decayTime := PhHSlider new
		             label: 'JamFreeVerbDecayTime'
		             values: #( 0.3 0 1 0.01 ).
	self initializeControlParameters
]

{ #category : 'initialization' }
JamFreeVerb >> initializeControlParameters [

	| decay |
	super initializeControlParameters.
	decay := #JamFreeVerbDecayTime -> (PhControlParameter new
		          label: #JamFreeVerbDecayTime;
		          description: 'Reverb duration';
		          min: 0;
		          max: 1;
		          step: 0.01;
		          value: 0.3;
		          widgetType: #horizontalsSlider).



	self controlParameters add: decay
]

{ #category : 'accessing' }
JamFreeVerb >> input [ 

	^ input
]

{ #category : 'connecting' }
JamFreeVerb >> patchedWith: aBox [

input := aBox 

	
]
