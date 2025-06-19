Class {
	#name : 'JamEffectTests',
	#superclass : 'TestCase',
	#category : 'PharoJamSession-Tests',
	#package : 'PharoJamSession',
	#tag : 'Tests'
}

{ #category : 'running' }
JamEffectTests >> setUp [

	super setUp.
	
	
]

{ #category : 'tests' }
JamEffectTests >> testJamEchoDelayAsDsp [

   | fx |
fx := JamEchoDelay new.
self assert: fx numberOfInputs equals: 1.
	self deny: fx asDsp isNull
]

{ #category : 'tests' }
JamEffectTests >> testJamFreeverbAsDsp [

	| fx |
	fx := JamFreeVerb new.
	self assert: fx numberOfInputs equals: 1.
	self deny: fx asDsp isNull
]
