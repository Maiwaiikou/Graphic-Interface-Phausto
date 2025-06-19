"
FreeVerb Mono with just simplified controls
"
Class {
	#name : 'JamFreeVerb',
	#superclass : 'FreeverbMono',
	#category : 'PharoJamSession-Effect',
	#package : 'PharoJamSession',
	#tag : 'Effect'
}

{ #category : 'initialization' }
JamFreeVerb >> initialize [

	| decayTime |
	super initialize.
	numberOfInputs := 1.
	decayTime := PhHSlider new
		             label: 'JamFreeVerbDecayTime'
		             values: #( 0.3 0 1 0.01 ).
	fb1 := decayTime .	
	fb2 := decayTime .
]
