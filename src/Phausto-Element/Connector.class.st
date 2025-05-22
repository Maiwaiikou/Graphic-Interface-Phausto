Class {
	#name : 'Connector',
	#superclass : 'BlElement',
	#instVars : [
		'isInputConnect',
		'isOutputConnect',
		'line',
		'connectTo'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'as yet unclassified' }
Connector >> calcMiddleWith: anInteger and: anotherInteger [
	anInteger < anotherInteger
		ifTrue: [ ^ anInteger + (anotherInteger - anInteger / 2) ]
		ifFalse: [ ^ anotherInteger + (anInteger - anotherInteger / 2) ]
	
]

{ #category : 'initialization' }
Connector >> checkBeforeDisconnect [

	self connectTo ifNotNil: [
		self isOutputConnect
			ifTrue: [ self disconnect: connectTo inputConnect ]
			ifFalse: [
				self disconnect: connectTo outputConnect ] ]
]

{ #category : 'as yet unclassified' }
Connector >> connect: aConnector [

	{
		self.
		aConnector } do: [ :c |
		c checkBeforeDisconnect.
		c switchColor ].
	self connectTo: aConnector parent.
	aConnector connectTo: self parent
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
Connector >> disconnect: aConnector [

	connectTo ifNil: [ ^ self ].
	aConnector background: Color red.
	aConnector connectTo: nil.
	"aConnector line geometry = BlPolylineGeometry
		ifTrue: [ aConnector line: BlElement new ]
		ifFalse: [ line := BlElement new ]."
	connectTo := nil
]

{ #category : 'initialization' }
Connector >> initialize [

	super initialize.
	isInputConnect := false.
	isOutputConnect := false.
	self zIndex: 3.
	line := BlElement new.
	self background: Color red.
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
		self resetInit.
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

{ #category : 'testing' }
Connector >> isUsefulSwitchColor [

	^ self background paint color ~= Color green
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

	self background: Color red.
	
]

{ #category : 'blinking' }
Connector >> switchColor [
	self background paint color= Color red ifTrue: [
		self background: Color lightGreen.
		^ self ].
	self background: Color red
]

{ #category : 'as yet unclassified' }
Connector >> updateLine [

	| points first last midX |
	line geometry class = BlPolylineGeometry ifFalse: [ ^ self ].
	points := OrderedCollection new.
	first := self positionInSpace.
	last := isOutputConnect
		        ifTrue: [ connectTo inputConnect positionInSpace ]
		        ifFalse: [ connectTo outputConnect positionInSpace ].

	midX := self calcMiddleWith: first x and: last x.
	points add: first.
	points add: midX @ first y.
	points add: midX @ last y.
	points add: last.
	line geometry: (BlPolylineGeometry vertices: points)
]
