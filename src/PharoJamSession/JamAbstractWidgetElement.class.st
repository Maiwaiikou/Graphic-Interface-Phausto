"
I'm the abstract widget element of the PharoJamSession, i'm compose of a BarElement who can move me in the interface, with at least one Cconnector and maximum 2 to link my attribut phaustoSound to another widget and with a slider container which regroup sliders of each parameter of my phaustoSound. 
My subclasses are the concrete widget elements for Instruments-Effects and the Icon-only widget for Microphone input and Speaker output
"
Class {
	#name : 'JamAbstractWidgetElement',
	#superclass : 'ToElement',
	#instVars : [
		'action',
		'barElement',
		'name',
		'slidersDic',
		'slidersLabels',
		'configuredAttributes',
		'phaustoSound',
		'phaustoSoundInit',
		'inputConnect',
		'outputConnect',
		'announcer',
		'slidersContainer',
		'unitGenerator'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'configuring' }
JamAbstractWidgetElement class >> onlyWithInputConnector [

	| widget |
	widget := self new.
	widget outputConnect: nil.
	^ widget
]

{ #category : 'configuring' }
JamAbstractWidgetElement class >> onlyWithOutputConnector [

	| widget |
	widget := self new.
	widget inputConnect:nil.
	^ widget
]

{ #category : 'configuring' }
JamAbstractWidgetElement class >> typeOfWidget: aPhaustoElement [
	
	(aPhaustoElement numberOfInputs = 0) ifTrue: [ ^ self onlyWithOutputConnector ].
	(aPhaustoElement numberOfOutputs = 0) ifTrue: [ ^ self onlyWithInputConnector ].
	^ self new.
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> action [
	^ action
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> action: aBlock [
	action := aBlock
]

{ #category : 'drawing' }
JamAbstractWidgetElement >> adjustLine: aConnector [

	| points line first last midX |
	"aConnector line geometry class = BlPolylineGeometry ifFalse: [
		^ self ]."
	points := OrderedCollection new.
	first := aConnector line geometry vertices first.
	last := aConnector line geometry vertices last.
	midX := aConnector calcMiddleWith: first x and: last x.
	points add: first.
	points add: midX @ first y.
	points add: midX @ last y.
	points add: last.
	line := BlElement new.
	line geometry: (BlBezierCurveGeometry controlPoints: points).
	line outskirts: BlOutskirts centered.
	line border: (BlBorder paint: Color black width: 3).
	line addEventHandlerOn: BlClickEvent do: [
		aConnector disconnect.
		self notifyDrawingLine ].
	aConnector line: line.
	self notifyDrawingLine
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> announcer [
	^ announcer ifNil: [ announcer := Announcer new. ]
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> atRandomPos [

	| x y |
	x := (1 to: 600) atRandom.
	y := (50 to: 600) atRandom.
	self position: x @ y.
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> barElement [
	^ barElement
]

{ #category : 'initialize-release' }
JamAbstractWidgetElement >> close [
	(self isConnector: inputConnect) ifTrue: [
		inputConnect checkBeforeDisconnect ].
	(self isConnector: outputConnect) ifTrue: [
		outputConnect checkBeforeDisconnect ].
	"remove from synthpatch"
	self parent synthPatch remove: self phaustoSound  ifAbsent: [ ] .
	self resetToInit.
	self parent childrenElements remove: self ifAbsent: [ ].
	
	self removeFromParent
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> configuredAttributes [
	^ configuredAttributes
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> configuredAttributes: anOrderedCollection [
	"Attributes are defined in the theme and save for configure the label value which change everytime"
	configuredAttributes := anOrderedCollection
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> configuredString: aString [
	|stringRoped|
	stringRoped := aString asRopedText.
	configuredAttributes ifNotEmpty: [ stringRoped attributes: configuredAttributes].
	^ stringRoped.
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> connectSlider: aToSlider toLabel: aTextElement [

	aToSlider callBack: [ :value |
		aTextElement text: (self configuredString: ((value round: 2) asString)) .
		self parent activeDSP setValue: value parameter: aToSlider label.
		
		].

	aToSlider constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all: 5) ].
	slidersContainer addChild: aToSlider
]

{ #category : 'drawing' }
JamAbstractWidgetElement >> drawALine: points atConnector: aConnector [

	| newline |
	newline := BlElement new.
	newline border: (BlBorder paint: Color black width: 2).
	newline geometry: (BlPolylineGeometry vertices: points).
	newline zIndex: 2.
	newline outskirts: BlOutskirts centered.
	aConnector line: newline.
	self notifyDrawingLine
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initialize [

	super initialize.
	name := ''.
	slidersDic := Dictionary new.
	slidersLabels := OrderedCollection new.
	configuredAttributes := OrderedCollection new.
	self layout: BlFrameLayout new.
	self initializeBar.
	self initializeInputConnect.
	self initializeOutputConnect.
	self initializeSlidersContainer.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	self initializeEvents.
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeBar [

	barElement := JamBarElement new name: self name.
	barElement constraintsDo: [ :c |
		c vertical fitContent.
		c frame horizontal alignCenter ].
	barElement closeButton newClickAction: [ self close ].
	self initializeDragWidgetEventOn: barElement.

	self addChild: barElement
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeDragWidgetEventOn: anElement [

	| offset |
	anElement addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - self position ].
	anElement addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		self position: evt position - offset ].
	anElement addEventHandlerOn: BlDragEndEvent do: [ :evt |
		evt consumed: true.
		(self isConnector: inputConnect) ifTrue: [ inputConnect updateLine ].
		(self isConnector: outputConnect) ifTrue: [
			(outputConnect connectorWhichHaveLine:
				 outputConnect connectorConnected) updateLine ].
		self notifyDrawingLine ]
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeEvents [

	self addEventFilterOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(self isConnector: evt gestureSource) ifTrue: [
			| line |
			line := evt gestureSource line.
			evt gestureSource isOutputConnect
				ifTrue: [
					line geometry vertices: line geometry vertices
						, { (inputConnect positionInSpace + (inputConnect extent / 2)) }.
					inputConnect connect: evt gestureSource ]
				ifFalse: [
					line geometry vertices: line geometry vertices
						,
						{ (outputConnect positionInSpace + (outputConnect extent / 2)) }.
					outputConnect connect: evt gestureSource ].
			self adjustLine: evt gestureSource.
			self notifyDrawingLine ] ]
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeInputConnect [

	inputConnect := JamInputConnector new.
	inputConnect constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
		c margin: (BlInsets all: -30) ].
	inputConnect addEventFilterOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isOutputConnect
			ifTrue: [
				inputConnect connect: evt gestureSource.
				self adjustLine: evt gestureSource ]
			ifFalse: [
				evt gestureSource line: nil.
				self notifyDrawingLine ] ].
	self addChild: inputConnect
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeOutputConnect [

	outputConnect := JamConnector new isOutputConnect: true.
	outputConnect constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	outputConnect transformDo: [ :t | t translateBy: 30 @ 0 ].
	outputConnect addEventFilterOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isInputConnect
			ifTrue: [
				outputConnect connect: evt gestureSource.
				outputConnect line: evt gestureSource line.
				evt gestureSource line: nil.
				self adjustLine: outputConnect ]
			ifFalse: [
				evt gestureSource line: nil.
				self notifyDrawingLine ] ].
	self addChild: outputConnect
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeSliderLabel: aString [

	| label valueLabel container |
	label := BlTextElement new.
	label text: (aString , ':  ') asRopedText.
	valueLabel := BlTextElement new.
	valueLabel text: (slidersDic at:aString) value asRopedText.
	slidersLabels addAll: {
			label.
			valueLabel }.
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c frame horizontal alignCenter.
			             c margin: (BlInsets all: 5).
			             c vertical fitContent.
			             c horizontal fitContent ];
		             addChildren: {
				             label.
				             valueLabel }.

	slidersContainer addChild: container.

	^ valueLabel
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeSliders [ 

	slidersDic keysAndValuesDo: [ :key :value | 
		|sliderLabel|
		sliderLabel := self initializeSliderLabel: key.
		self connectSlider: value toLabel: sliderLabel.
		].
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> initializeSlidersContainer [

	slidersContainer := BlElement new.
	slidersContainer layout: BlLinearLayout new.
	slidersContainer layout beVertical.
	slidersContainer constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent.
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self addChild: slidersContainer
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> inputConnect [

	^ inputConnect
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> inputConnect: aConnector [

	aConnector ifNil: [ (self children includes: inputConnect) ifTrue: [ self removeChild: inputConnect. ]].
	inputConnect := aConnector
]

{ #category : 'testing' }
JamAbstractWidgetElement >> isConnectedTo: aWidget [

	aWidget ifNil: [ ^ false ].
	(outputConnect connectTo isNotNil and:
		 outputConnect connectTo ~= aWidget) ifTrue: [
		^ outputConnect connectTo isConnectedTo: aWidget ].
	^ outputConnect connectTo = aWidget
]

{ #category : 'testing' }
JamAbstractWidgetElement >> isConnector: anElement [

	anElement ifNil: [ ^ false ].
	^ ((anElement class inheritsFrom: JamConnector) or: (anElement class = JamConnector))
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> name [
	^ name
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> name: aString [
	name := aString.
	barElement name: aString.
]

{ #category : 'instance creation' }
JamAbstractWidgetElement >> newRawSkin [
	^ JamWidgetElementSkin new
]

{ #category : 'announcer connection' }
JamAbstractWidgetElement >> notifyConnection [

	self subclassResponsibility 
]

{ #category : 'announcer connection' }
JamAbstractWidgetElement >> notifyDisconnection [

	self subclassResponsibility 
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> notifyDrawingLine [
	self announcer announce: LineCurrentlyDrawAnnouncer new.
]

{ #category : 'event' }
JamAbstractWidgetElement >> onConnection [
	((self isConnector: outputConnect ) and:
		 outputConnect connectTo isNotNil) ifTrue: [ self onConnectionWith: outputConnect connectTo inputConnect ].
	((self isConnector: inputConnect) and:
		 inputConnect connectTo isNotEmpty) ifTrue: [ inputConnect connectTo do: [ :widgets | self onConnectionWith: widgets outputConnect ] ]
]

{ #category : 'enumerating' }
JamAbstractWidgetElement >> onConnectionWith: aConnector [

	phaustoSound ifNotNil: [
		aConnector isOutputConnect
			ifTrue: [
				aConnector parent phaustoSound:
					aConnector parent phaustoSound => phaustoSound ]
			ifFalse: [ phaustoSound := phaustoSound => aConnector phaustoSound ] ]
]

{ #category : 'event' }
JamAbstractWidgetElement >> onDisconnection [
	phaustoSound := phaustoSoundInit
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> outputConnect [

	^ outputConnect
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> outputConnect: aConnector [

aConnector ifNil: [ (self children includes: outputConnect) ifTrue: [ self removeChild: outputConnect. ]].
	
	outputConnect := aConnector
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> phaustoSound [
	^ phaustoSound
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> phaustoSound: aPhaustoSoundAsDsp [

	phaustoSound := aPhaustoSoundAsDsp.
	self phaustoSoundInit: aPhaustoSoundAsDsp.
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> phaustoSoundInit [
	^ phaustoSoundInit
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> phaustoSoundInit: aPhaustoSound [
	phaustoSoundInit ifNil: [ phaustoSoundInit := aPhaustoSound ].
]

{ #category : 'initialization' }
JamAbstractWidgetElement >> resetToInit [

	(self isConnector: inputConnect) ifTrue: [ inputConnect resetInit ].
	(self isConnector: outputConnect) ifTrue: [ outputConnect resetInit ].
	self notifyDrawingLine
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> sliderIndex: aSlider [

	| key |
	1 to: slidersDic size do: [ :i |
		key := slidersDic keys at: i.
		((slidersDic at: key) = aSlider) ifTrue: [ ^ i ] ].
	^ 0
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> slidersContainer [
	^ slidersContainer
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> slidersDic [

	^ slidersDic
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> slidersDic: aDictionaryOfSlidersWithLabelKey [

	slidersDic := aDictionaryOfSlidersWithLabelKey.
	self initializeSliders.
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> slidersLabels [
	^ slidersLabels
]

{ #category : 'accessing' }
JamAbstractWidgetElement >> slidersLabels: anOrderedCollection [
	slidersLabels := anOrderedCollection.
]
