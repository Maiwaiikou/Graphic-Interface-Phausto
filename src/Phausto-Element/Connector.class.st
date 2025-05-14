Class {
	#name : 'Connector',
	#superclass : 'BlElement',
	#instVars : [
		'isLeftConnect',
		'isRightConnect',
		'line',
		'connectTo'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'initialization' }
Connector >> initialize [

	super initialize.
	isLeftConnect := false.
	isRightConnect := false.
	line := BlElement new.
	self background: Color red.
	self border: (BlBorder paint: Color black width: 2).
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self border: (BlBorder paint: Color black width: 1)
]

{ #category : 'accessing' }
Connector >> isLeftConnect [
	^ isLeftConnect 
]

{ #category : 'accessing' }
Connector >> isLeftConnect: aBoolean [
	isLeftConnect := aBoolean.
]

{ #category : 'accessing' }
Connector >> isRightConnect [

	^ isRightConnect
]

{ #category : 'accessing' }
Connector >> isRightConnect: aBoolean [
	isRightConnect := aBoolean.
]

{ #category : 'initialization' }
Connector >> line [
	^line
]

{ #category : 'initialization' }
Connector >> line: aPolyLine [
	line := aPolyLine.
]
