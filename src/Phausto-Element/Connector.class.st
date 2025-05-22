Class {
	#name : 'Connector',
	#superclass : 'BlElement',
	#instVars : [
		'isInputConnect',
		'isOutputConnect',
		'line',
		'connectTo'
	],
	#category : 'Phausto-Element-Widget',
	#package : 'Phausto-Element',
	#tag : 'Widget'
}

{ #category : 'as yet unclassified' }
Connector >> calcMiddleWith: anInteger and: anotherInteger [
	anInteger < anotherInteger
		ifTrue: [ ^ anInteger + (anotherInteger - anInteger / 2) ]
		ifFalse: [ ^ anotherInteger + (anInteger - anotherInteger / 2) ]
	
]

{ #category : 'initialization' }
Connector >> checkBeforeDisconnect [

	self connectTo ifNotNil: [ self disconnect ]
]

{ #category : 'as yet unclassified' }
Connector >> connect: aConnector [

	self checkBeforeDisconnect.
	aConnector checkBeforeDisconnect.
	self connectTo: aConnector parent.
	aConnector connectTo: self parent.
]

{ #category : 'accessing' }
Connector >> connectTo [
	^ connectTo
]

{ #category : 'accessing' }
Connector >> connectTo: aWidget [

	connectTo := aWidget
]

{ #category : 'as yet unclassified' }
Connector >> connectorConnected [
	"Get the correct connector base on if this connector is an output or input"

	connectTo ifNil: [ ^ self ].
	self isOutputConnect
		ifTrue: [ ^ connectTo inputConnect ]
		ifFalse: [ ^ connectTo outputConnect ]
]

{ #category : 'as yet unclassified' }
Connector >> connectorWhichHaveLine: aConnector [

	aConnector line geometry class = BlPolylineGeometry
		ifTrue: [ ^ aConnector ]
		ifFalse: [ ^ self ].
]

{ #category : 'as yet unclassified' }
Connector >> disconnect [

	| aConnector |
	aConnector := self connectorConnected.
	(self connectorWhichHaveLine: aConnector) line: BlElement new.
	aConnector connectTo: nil.
	connectTo := nil
]

{ #category : 'initialization' }
Connector >> initialize [

	super initialize.
	isInputConnect := false.
	isOutputConnect := false.
	self zIndex: 3.
	line := BlElement new.
	self border: (BlBorder paint: Color black width: 2).
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self border: (BlBorder paint: Color black width: 1).
	self initializeDrag
]

{ #category : 'as yet unclassified' }
Connector >> initializeDrag [

	| points |
	self addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
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
Connector >> isInputConnect [

	^ isInputConnect
]

{ #category : 'accessing' }
Connector >> isInputConnect: aBoolean [

	isInputConnect := aBoolean
]

{ #category : 'accessing' }
Connector >> isOutputConnect [

	^ isOutputConnect
]

{ #category : 'accessing' }
Connector >> isOutputConnect: aBoolean [

	isOutputConnect := aBoolean
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
Connector >> resetInit [

	line := BlElement new.
	self checkBeforeDisconnect.
]

{ #category : 'as yet unclassified' }
Connector >> updateLine [
	"When the widget connected or the widget parent position move and there is another widget connected, we edit our visual connexion line to put it visually connect to the correct widget"

	| points first last midX sizeBound |
	sizeBound := self size / 2.
	line geometry class = BlPolylineGeometry ifFalse: [ ^ self ].
	points := OrderedCollection new.
	first := self positionInSpace.
	last := self connectorConnected positionInSpace.

	midX := self calcMiddleWith: (first x + sizeBound x) and: (last x + sizeBound x).
	points add: (first x + sizeBound x) @ (first y + sizeBound y).
	points add: midX @ (first y + sizeBound y).
	points add: midX @ (last y + sizeBound y).
	points add: (last x + sizeBound x) @ (last y + sizeBound y).
	line geometry: (BlPolylineGeometry vertices: points)
]
