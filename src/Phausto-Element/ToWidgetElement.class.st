Class {
	#name : 'ToWidgetElement',
	#superclass : 'ToElement',
	#instVars : [
		'barElement',
		'name',
		'phaustoSound',
		'labelVolume',
		'volumeSliders',
		'volumeValue',
		'leftConnect',
		'rightConnect',
		'lines',
		'announcer'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'as yet unclassified' }
ToWidgetElement class >> onlyWithLeftConnector [
	|widget|
	widget := self new.
	widget rightConnect: BlElement new.
	widget rightConnect background: BlBackground transparent; border: BlBorder empty.
	^ widget
]

{ #category : 'as yet unclassified' }
ToWidgetElement class >> onlyWithRightConnector [
	|widget|
	widget := self new.
	widget leftConnect: BlElement new.
	widget leftConnect background: BlBackground transparent; border: BlBorder empty.
	^ widget
]

{ #category : 'as yet unclassified' }
ToWidgetElement >> adjustLine: aConnector [

	| points line first last midX |
	(aConnector line geometry isKindOf: BlPolylineGeometry) ifFalse: [
		^ self ].
	points := OrderedCollection new.
	first := aConnector line geometry vertices first.
	last := aConnector line geometry vertices last.
	midX := aConnector middleX.
	points add: first.
	points add: midX @ first y.
	points add: midX @ last y.
	points add: last.
	line := BlElement new.
	line geometry: (BlPolylineGeometry vertices: points).
	line outskirts: BlOutskirts centered.
	line border: (BlBorder paint: Color black width: 2).
	aConnector line: line.
	self notifyDrawingLine
]

{ #category : 'accessing' }
ToWidgetElement >> announcer [
	^ announcer ifNil: [ announcer := Announcer new. ]
]

{ #category : 'accessing' }
ToWidgetElement >> atRandomPos [

	| x y |
	x := (1 to: 600) atRandom.
	y := (50 to: 600) atRandom.
	self position: x @ y.
]

{ #category : 'accessing' }
ToWidgetElement >> barElement [
	^ barElement
]

{ #category : 'accessing' }
ToWidgetElement >> configuredString: aString [
	^ aString asRopedText attributes: { (BlTextForegroundAttribute paint: Color black) }
]

{ #category : 'accessing' }
ToWidgetElement >> configuredVolumeSliders [
	volumeSliders := ToSliders new.
	volumeSliders announcer when:AnnouncerValueChange send:#draw to: self.
	volumeSliders constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all:35)].
	
	
	
]

{ #category : 'drawing' }
ToWidgetElement >> draw [

	self removeChildren.
	self drawBar.
	self drawLabelVolume.
	self addChild: leftConnect.
	self addChild: rightConnect
]

{ #category : 'drawing' }
ToWidgetElement >> drawALine: points atConnector: aConnector [

	| newline |
	newline := BlElement new.
	newline border: (BlBorder paint: Color black width: 2).
	newline geometry: (BlPolylineGeometry vertices: points).
	newline zIndex: 2.
	newline outskirts: BlOutskirts centered.
	aConnector line: newline.
	self notifyDrawingLine
]

{ #category : 'drawing' }
ToWidgetElement >> drawBar [

	| offset |
	barElement := BarElement new name: self name.
	barElement border: (BlBorder paint: Color black width: 1).
	barElement constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignCenter ].
	barElement closeButton newClickAction: [
		self parent childrenElements remove: self.
		self removeFromParent ].

	barElement addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - self position ].
	barElement addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		self position: evt position - offset ].

	self addChild: barElement
]

{ #category : 'drawing' }
ToWidgetElement >> drawLabelVolume [
	labelVolume := BlTextElement new.
	labelVolume text: ('Volume :', volumeSliders value asString) asRopedText.
	labelVolume constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all:25)].
	self addChild: labelVolume.
	self addChild: volumeSliders.
	
]

{ #category : 'drawing' }
ToWidgetElement >> drawLeftConnect [

	leftConnect := Connector new isLeftConnect: true.
	leftConnect constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
		c margin: (BlInsets all: -30) ].
	leftConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isRightConnect
			ifTrue: [
				self adjustLine: evt gestureSource.
				leftConnect connect: evt gestureSource. ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ]
]

{ #category : 'drawing' }
ToWidgetElement >> drawRightConnect [

	rightConnect := Connector new isRightConnect: true.
	rightConnect constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	rightConnect transformDo: [ :t | t translateBy: 30 @ 0 ].
	rightConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isLeftConnect
			ifTrue: [ self adjustLine: evt gestureSource.
				rightConnect connect: evt gestureSource. ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ]
]

{ #category : 'initialization' }
ToWidgetElement >> initialize [

	super initialize.
	name := ''.
	lines := OrderedCollection new.
	self configuredVolumeSliders.
	self layout: BlFrameLayout new.
	self drawLeftConnect.
	self drawRightConnect.
	self draw.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(evt gestureSource isKindOf: Connector) ifTrue: [
			evt gestureSource line: BlElement new.
			self draw ] ].
]

{ #category : 'testing' }
ToWidgetElement >> isConnector: anElement [
	^ anElement class = Connector.
	
]

{ #category : 'accessing' }
ToWidgetElement >> labelVolume [
	^ labelVolume 
]

{ #category : 'accessing' }
ToWidgetElement >> leftConnect [
	^  leftConnect
]

{ #category : 'accessing' }
ToWidgetElement >> leftConnect: anElement [
	leftConnect := anElement.
]

{ #category : 'accessing' }
ToWidgetElement >> lines [
	^ lines
]

{ #category : 'accessing' }
ToWidgetElement >> lines: aCollectionOfBlPolygeon [
	lines := aCollectionOfBlPolygeon.
]

{ #category : 'accessing' }
ToWidgetElement >> name [
	^ name
]

{ #category : 'accessing' }
ToWidgetElement >> name: aString [
	name := aString.
	self draw.
]

{ #category : 'instance creation' }
ToWidgetElement >> newRawSkin [
	^ ToWidgetElementSkin new
]

{ #category : 'accessing' }
ToWidgetElement >> notifyDrawingLine [
	self announcer announce: LineCurrentlyDrawAnnouncer new.
]

{ #category : 'accessing' }
ToWidgetElement >> phaustoSound [
	^ phaustoSound
]

{ #category : 'accessing' }
ToWidgetElement >> phaustoSound: aPhaustoSound [
	phaustoSound := aPhaustoSound stereo asDsp.
]

{ #category : 'accessing' }
ToWidgetElement >> rightConnect [
	^  rightConnect
]

{ #category : 'accessing' }
ToWidgetElement >> rightConnect: anElement [
	rightConnect := anElement.
]

{ #category : 'accessing' }
ToWidgetElement >> volumeSliders [
	^ volumeSliders 
]

{ #category : 'accessing' }
ToWidgetElement >> volumeValue [
	^ volumeSliders value 
]
