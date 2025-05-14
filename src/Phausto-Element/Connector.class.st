Class {
	#name : 'Connector',
	#superclass : 'BlElement',
	#instVars : [
		'left',
		'right',
		'line'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'initialization' }
Connector >> initialize [
	super initialize.
	line := BlElement new.
	self background: Color red.
	self border: (BlBorder paint: Color black width: 2).
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self border: (BlBorder paint: Color black width:1).
]

{ #category : 'initialization' }
Connector >> left [
	^ left
]

{ #category : 'initialization' }
Connector >> left: aConnector [
	left := aConnector
]

{ #category : 'initialization' }
Connector >> line [
	^line
]

{ #category : 'initialization' }
Connector >> line: aPolyLine [
	line := aPolyLine.
]

{ #category : 'initialization' }
Connector >> right [
	^ right
]

{ #category : 'initialization' }
Connector >> right: aConnector [
	right := aConnector
]
