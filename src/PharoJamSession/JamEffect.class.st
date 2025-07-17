"
Superclass for JamSession effects.
Effects are used to process sound, they need an audio input.
"
Class {
	#name : 'JamEffect',
	#superclass : 'UnitGenerator',
	#category : 'PharoJamSession-Effect',
	#package : 'PharoJamSession',
	#tag : 'Effect'
}

{ #category : 'converting' }
JamEffect >> asBox [ 


	^ PhBox new fromString: self code
]

{ #category : 'initialization' }
JamEffect >> initialize [

	super initialize.
	numberOfInputs := 1.
	
]

{ #category : 'initialization' }
JamEffect >> initializeControlParameters [

	controlParameters := Dictionary new
]
