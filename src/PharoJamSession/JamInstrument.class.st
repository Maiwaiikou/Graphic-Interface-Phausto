"
Superclass for all instruments
"
Class {
	#name : 'JamInstrument',
	#superclass : 'UnitGenerator',
	#category : 'PharoJamSession-Instrument',
	#package : 'PharoJamSession',
	#tag : 'Instrument'
}

{ #category : 'converting' }
JamInstrument >> asBox [ 

^ PhBox new fromString: self code
]

{ #category : 'converting' }
JamInstrument >> asWidget [
self shouldBeImplemented 
]

{ #category : 'initialization' }
JamInstrument >> initialize [ 
super initialize .
self initializeControlParameters .
]

{ #category : 'initialization' }
JamInstrument >> initializeControlParameters [ 

controlParameters  := Dictionary new
]
