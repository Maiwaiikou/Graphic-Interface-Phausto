Class {
	#name : 'JamEffectTests',
	#superclass : 'TestCase',
	#category : 'PharoJamSession-Tests',
	#package : 'PharoJamSession',
	#tag : 'Tests'
}

{ #category : 'tests' }
JamEffectTests >> testJamEchoDelayAsDsp [

	self assert: JamEchoDelay new asDsp isNull equals: false
]
