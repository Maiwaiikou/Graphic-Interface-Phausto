Class {
	#name : 'ToWidgetElement',
	#superclass : 'ToElement',
	#instVars : [
		'barElement',
		'name',
		'slidersDic',
		'phaustoSound',
		'labelVolume',
		'volumeSliders',
		'volumeValue',
		'inputConnect',
		'outputConnect',
		'lines',
		'announcer'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'as yet unclassified' }
ToWidgetElement class >> onlyWithInputConnector [

	| widget |
	widget := self new.
	widget outputConnect: BlElement new.
	widget draw.
	^ widget
]

{ #category : 'as yet unclassified' }
ToWidgetElement class >> onlyWithOutputConnector [

	| widget |
	widget := self new.
	widget inputConnect: BlElement new.
	widget draw.
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
	midX := aConnector calcMiddleWith: first x and: last x.
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
	"self drawLabelVolume."
	self drawLabel.
	self addChild: inputConnect.
	self addChild: outputConnect.
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
		(self isConnector: inputConnect) ifTrue: [
			inputConnect checkBeforeDisconnect ].
		(self isConnector: outputConnect) ifTrue: [
			outputConnect checkBeforeDisconnect ].
		self resetToInit.
		self parent childrenElements remove: self.
		self removeFromParent ].

	barElement addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - self position ].
	barElement addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		self position: evt position - offset
		"(self isConnector:leftConnect) ifTrue: [ leftConnect updateLine. self notifyDrawingLine ].
		(self isConnector:rightConnect) ifTrue: [ rightConnect updateLine. self notifyDrawingLine ]." ].
	barElement
		addEventHandlerOn: BlDragEndEvent
		do: [ :evt | evt consumed: true ].

	self addChild: barElement
]

{ #category : 'drawing' }
ToWidgetElement >> drawLabel [

	| label key dicSize |
	dicSize := slidersDic size.
	1 to: dicSize do: [ :i |
		key := slidersDic keys at: i.
		label := BlTextElement new.
		label text:
			(key , ' : ' , (slidersDic at: key) value asString) asRopedText.
		label constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c margin: (BlInsets all: 30 * dicSize / (dicSize - i + 1)) ].
		self addChild: label.
		self drawSlider: (slidersDic at: key) ]
]

{ #category : 'drawing' }
ToWidgetElement >> drawLabelVolume [

	labelVolume := BlTextElement new.
	labelVolume text:
		('Volume :' , volumeSliders value asString) asRopedText.
	labelVolume constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all: 25) ].
	self addChild: labelVolume.
	self addChild: volumeSliders
]

{ #category : 'drawing' }
ToWidgetElement >> drawLeftConnect [

	inputConnect := Connector new isInputConnect: true.
	inputConnect constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
		c margin: (BlInsets all: -30) ].
	inputConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isOutputConnect
			ifTrue: [
				self adjustLine: evt gestureSource.
				inputConnect connect: evt gestureSource ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ]
]

{ #category : 'drawing' }
ToWidgetElement >> drawRightConnect [

	outputConnect := Connector new isOutputConnect: true.
	outputConnect constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	outputConnect transformDo: [ :t | t translateBy: 30 @ 0 ].
	outputConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isInputConnect
			ifTrue: [
				self adjustLine: evt gestureSource.
				outputConnect connect: evt gestureSource ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ]
]

{ #category : 'accessing' }
ToWidgetElement >> drawSlider: aSlider [

	| dicSize index |
	dicSize := slidersDic size.
	index := self sliderIndex: aSlider.
	aSlider announcer when: AnnouncerValueChange send: #draw to: self.
	aSlider constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all: 40 * dicSize / (dicSize - index + 1)) ].
	self addChild: aSlider
]

{ #category : 'initialization' }
ToWidgetElement >> initialize [

	super initialize.
	name := ''.
	lines := OrderedCollection new.
	slidersDic := Dictionary new.
	self configuredVolumeSliders.
	self layout: BlFrameLayout new.
	self drawLeftConnect.
	self drawRightConnect.
	self draw.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(evt gestureSource isKindOf: Connector) ifTrue: [
			evt gestureSource line: BlElement new.
			self draw ] ]
]

{ #category : 'accessing' }
ToWidgetElement >> inputConnect [

	^ inputConnect
]

{ #category : 'accessing' }
ToWidgetElement >> inputConnect: aConnector [

	inputConnect := aConnector
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
ToWidgetElement >> outputConnect [

	^ outputConnect
]

{ #category : 'accessing' }
ToWidgetElement >> outputConnect: aConnector [

	outputConnect := aConnector
]

{ #category : 'accessing' }
ToWidgetElement >> phaustoSound [
	^ phaustoSound
]

{ #category : 'accessing' }
ToWidgetElement >> phaustoSound: aPhaustoSound [
	phaustoSound := aPhaustoSound stereo asDsp.
]

{ #category : 'initialization' }
ToWidgetElement >> resetToInit [

	volumeSliders position: 0 @ 0.
	volumeSliders value: 0.
	(self isConnector: inputConnect) ifTrue: [
		inputConnect line: BlElement new.
		inputConnect resetInit ].
	(self isConnector: outputConnect) ifTrue: [
		outputConnect line: BlElement new.
		outputConnect resetInit ]
]

{ #category : 'as yet unclassified' }
ToWidgetElement >> sliderIndex: aSlider [

	| key |
	1 to: slidersDic size do: [ :i |
		key := slidersDic keys at: i.
		((slidersDic at: key) = aSlider) ifTrue: [ ^ i ] ].
	^ 0
]

{ #category : 'accessing' }
ToWidgetElement >> slidersDic [

	^ slidersDic
]

{ #category : 'accessing' }
ToWidgetElement >> slidersDic: aDictionaryOfSlidersWithLabelKey [

	slidersDic := aDictionaryOfSlidersWithLabelKey.
	self draw.
]

{ #category : 'accessing' }
ToWidgetElement >> volumeSliders [
	^ volumeSliders 
]

{ #category : 'accessing' }
ToWidgetElement >> volumeValue [
	^ volumeSliders value 
]
