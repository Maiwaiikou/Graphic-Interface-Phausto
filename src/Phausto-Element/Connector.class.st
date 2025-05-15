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

{ #category : 'as yet unclassified' }
Connector >> connect: aConnector [

	self connectTo: aConnector parent.
	aConnector connectTo: self parent.
	self switchColor.
	aConnector switchColor.
	aConnector line: self line
]

{ #category : 'accessing' }
Connector >> connectTo [
	^ connectTo
]

{ #category : 'accessing' }
Connector >> connectTo: aWidget [

	connectTo := aWidget
]

{ #category : 'initialization' }
Connector >> initialize [

	super initialize.
	isLeftConnect := false.
	isRightConnect := false.
	self zIndex: 3.
	line := BlElement new.
	self background: Color red.
	self border: (BlBorder paint: Color black width: 2).
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self border: (BlBorder paint: Color black width: 1).
	self initializeDrag.
]

{ #category : 'as yet unclassified' }
Connector >> initializeDrag [

	| points |
	self addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		self resetInitBackgroundColor.
		points := OrderedCollection new ].
	self addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		points add: evt position.
		parent drawALine: points atConnector: self ].
	self
		addEventHandlerOn: BlDragEndEvent
		do: [ :evt | evt consumed: true ]
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

{ #category : 'as yet unclassified' }
Connector >> middleX [

	| first last |
	first := line geometry vertices first x.
	last := line geometry vertices last x.
	first < last
		ifTrue: [ ^ first + (last - first/2) ]
		ifFalse: [ ^ last + (first - last/2) ]
]

{ #category : 'initialization' }
Connector >> resetInitBackgroundColor [

	self background: Color red.
	self connectTo ifNotNil: [ self isRightConnect ifTrue: [ connectTo leftConnect background: Color red ] ifFalse: [connectTo rightConnect background: Color red]].
]

{ #category : 'blinking' }
Connector >> switchColor [
	self background paint color= Color red ifTrue: [
		self background: Color lightGreen.
		^ self ].
	self background: Color red
]
