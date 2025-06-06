Class {
	#name : 'JamInstrumentTests',
	#superclass : 'TestCase',
	#category : 'PharoJamSession-Tests',
	#package : 'PharoJamSession',
	#tag : 'Tests'
}

{ #category : 'tests' }
JamInstrumentTests >> testJamBlowWhistleBottleAsDsp [

	self assert: JamBlowWhistleBottle new asDsp isNull equals: false
]

{ #category : 'tests' }
JamInstrumentTests >> testJamKisanaAsDsp [

self assert: JamKisana new asDsp isNull equals: false
]

{ #category : 'tests' }
JamInstrumentTests >> testJamSoftHarpAsDsp [

	self assert: JamSoftHarp new asDsp isNull equals: false
]
