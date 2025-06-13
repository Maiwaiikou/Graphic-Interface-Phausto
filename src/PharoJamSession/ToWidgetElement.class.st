"
I'm the main caracter of the PharoJamSession, i'm compose of a BarElement who can move me in the interface, with at least one Cconnector and maximum 2 to link my attribut phaustoSound to another widget and with a slider container which regroup sliders of each parameter of my phaustoSound. 
"
Class {
	#name : 'ToWidgetElement',
	#superclass : 'ToElement',
	#instVars : [
		'barElement',
		'name',
		'slidersDic',
		'phaustoSound',
		'inputConnect',
		'outputConnect',
		'announcer',
		'slidersContainer'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'configuring' }
ToWidgetElement class >> configureFor: anArrayOfClassName [

	| widgetsList widget currentControlParameter phControlParameter |
	widgetsList := OrderedCollection new.
	anArrayOfClassName do: [ :osc |
		widget := (self typeOfWidget: osc new)
			          name: osc asString;
			          phaustoSound: (osc new stereo asDsp).
		currentControlParameter := osc new controlParameters.
		currentControlParameter keysDo: [ :key |
			phControlParameter := currentControlParameter at: key.
			widget slidersDic
				at: key asString
				put: (ToSliders withAPhControlParam: phControlParameter) ].
		widget initializeSliders.
		widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'configuring' }
ToWidgetElement class >> configureWithoutSoundFor: anArrayOfClassName [

	| widgetsList widget currentControlParameter phControlParameter |
	widgetsList := OrderedCollection new.
	anArrayOfClassName do: [ :className |
		widget := (self typeOfWidget: className new)
			          name: className asString.
		currentControlParameter := className new controlParameters.
		currentControlParameter keysDo: [ :key |
			phControlParameter := currentControlParameter at: key.
			widget slidersDic
				at: key asString
				put: (ToSliders withAPhControlParam: phControlParameter) ].
		widget initializeSliders.
		widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithDifferentTheme [

	<example>
	| interface theme |
	interface := Interface new clear.
	theme := ToRawTheme new.
	theme addTokenProperty:
		(ToTokenProperty name: #'widget-background' value: Color white).
	theme addTokenProperty:
		(ToTokenProperty name: #'bar-background' value: Color blue).
	theme addTokenProperty:
		(ToTokenProperty name: #'input-connect-background' value: Color pink).
	theme addTokenProperty: (ToTokenProperty
			 name: #'output-connect-background'
			 value: Color purple).
	theme addTokenProperty: (ToTokenProperty
			 name: #'output-connect-background'
			 value: Color purple).
	theme addTokenProperty:
		(ToTokenProperty name: #'slider-background' value: Color red).
	theme addTokenProperty:
		(ToTokenProperty name: #'button-background' value: Color lightGray).
	interface theme: theme.
	interface addChildElement: (self new
			 name: 'WindowsXp';
			 slidersDic: { ('Bug Counter' -> ToSliders new) } asDictionary).
	interface open
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithInputConnector [

	<example>
	| interface |
	interface := Interface new clear.
	interface addChildElement: (self onlyWithInputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithMultipleSliders [

	<example>
	| interface dict |
	dict := OrderedDictionary new.
	'abcdefghijklmnopqstuvwxyz' do: [ :c | dict at: (c asString) put: ToSliders new ].
	interface := Interface new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: dict).
	interface open
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithOutputConnector [

	<example>
	| interface |
	interface := Interface new clear.
	interface addChildElement: (self onlyWithOutputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithSliders [

	<example>
	| interface |
	interface := Interface new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: { ('Beauty' -> ToSliders new) } asDictionary).
	interface open.
]

{ #category : 'examples' }
ToWidgetElement class >> exampleWidgetWithTwoConnectors [

	<example>
	| interface |
	interface := Interface new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget').
	interface open
]

{ #category : 'configuring' }
ToWidgetElement class >> onlyWithInputConnector [

	| widget |
	widget := self new.
	widget removeChild: widget outputConnect.
	widget outputConnect: BlElement new.
	^ widget
]

{ #category : 'configuring' }
ToWidgetElement class >> onlyWithOutputConnector [

	| widget |
	widget := self new.
	widget removeChild: widget inputConnect.
	widget inputConnect: BlElement new.
	^ widget
]

{ #category : 'configuring' }
ToWidgetElement class >> typeOfWidget: aPhaustoElement [
	
	(aPhaustoElement numberOfInputs = 0) ifTrue: [ ^ self onlyWithOutputConnector ].
	(aPhaustoElement numberOfOutputs = 0) ifTrue: [ ^ self onlyWithInputConnector ].
	^ self new.
]

{ #category : 'widgets list' }
ToWidgetElement class >> widgetsEffects [

	| oscillators |
	oscillators := OrderedCollection new.
	Saturators subclasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ oscillators addAll: subClass subclasses ]
			ifFalse: [ oscillators add: subClass ] ].
	^ self configureWithoutSoundFor: oscillators
]

{ #category : 'widgets list' }
ToWidgetElement class >> widgetsInstruments [

	| instList |
	instList := OrderedCollection new.
	JamInstrument subclasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ instList addAll: subClass subclasses ]
			ifFalse: [ instList add: subClass ] ].
	^ self configureFor: instList
]

{ #category : 'widgets list' }
ToWidgetElement class >> widgetsOscillator [

	| oscillators |
	oscillators := OrderedCollection new.
	Oscillator subclasses do: [ :subClass |
			subClass hasSubclasses ifTrue: [oscillators addAll: subClass subclasses] ifFalse: [ oscillators add: subClass ] ].
	^ self configureFor: oscillators
]

{ #category : 'widgets list' }
ToWidgetElement class >> widgetsSynths [

	| synthsList |
	synthsList := OrderedCollection new.
	Synths subclasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ synthsList addAll: subClass subclasses ]
			ifFalse: [ synthsList add: subClass ] ].
	^ self configureWithoutSoundFor: synthsList
]

{ #category : 'drawing' }
ToWidgetElement >> adjustLine: aConnector [

	| points line first last midX |
	aConnector line geometry class = BlPolylineGeometry ifFalse: [
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
	line geometry: (BlBezierCurveGeometry controlPoints: points).
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

{ #category : 'initialize-release' }
ToWidgetElement >> close [

	self notifyEnableCreation.
	(self isConnector: inputConnect) ifTrue: [
		inputConnect checkBeforeDisconnect ].
	(self isConnector: outputConnect) ifTrue: [
		outputConnect checkBeforeDisconnect ].
	self resetToInit.
	self parent childrenElements remove: self ifAbsent: [].
	self removeFromParent
]

{ #category : 'accessing' }
ToWidgetElement >> configuredString: aString [
	^ aString asRopedText attributes: { (BlTextForegroundAttribute paint: Color black) }
]

{ #category : 'initialization' }
ToWidgetElement >> connectSlider: aToSlider toLabel: aTextElement [

	aToSlider callBack: [ :value | aTextElement text: (value round:2) asRopedText ].
	aToSlider constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all: 5) ].
	slidersContainer addChild: aToSlider
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

{ #category : 'initialization' }
ToWidgetElement >> initialize [

	super initialize.
	name := ''.
	slidersDic := Dictionary new.
	self layout: BlFrameLayout new.
	self initializeBar.
	self initializeInputConnect.
	self initializeOutputConnect.
	self initializeSlidersContainer.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(self isConnector: evt gestureSource) ifTrue: [
			evt gestureSource line: BlElement new.
			self notifyDrawingLine ] ]
]

{ #category : 'initialization' }
ToWidgetElement >> initializeBar [

	barElement := BarElement new name: self name.
	barElement border: (BlBorder paint: Color black width: 1).
	barElement constraintsDo: [ :c |
		c vertical fitContent.
		c frame vertical alignTop.
		c frame horizontal alignCenter ].
	barElement closeButton newClickAction: [ self close ].
	self initializeDragWidgetEventOn: barElement.

	self addChild: barElement
]

{ #category : 'initialization' }
ToWidgetElement >> initializeDragWidgetEventOn: anElement [

	| offset |
	anElement addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - self position ].
	anElement addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		self position: evt position - offset ].
	anElement addEventHandlerOn: BlDragEndEvent do: [ :evt |
		evt consumed: true.
		(self isConnector: inputConnect) ifTrue: [
			(inputConnect connectorWhichHaveLine:
				 inputConnect connectorConnected) updateLine ].
		(self isConnector: outputConnect) ifTrue: [
			(outputConnect connectorWhichHaveLine:
				 outputConnect connectorConnected) updateLine ].
		self notifyDrawingLine ]
]

{ #category : 'initialization' }
ToWidgetElement >> initializeInputConnect [

	inputConnect := Connector new isInputConnect: true.
	inputConnect constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
		c margin: (BlInsets all: -30).].
	inputConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isOutputConnect
			ifTrue: [
				inputConnect connect: evt gestureSource.
				self adjustLine: evt gestureSource.
			 ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ].
	self addChild: inputConnect
]

{ #category : 'initialization' }
ToWidgetElement >> initializeOutputConnect [

	outputConnect := Connector new isOutputConnect: true.
	outputConnect constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter. ].
	outputConnect transformDo: [ :t | t translateBy: 30 @ 0 ].
	outputConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isInputConnect
			ifTrue: [
				self adjustLine: evt gestureSource.
				outputConnect connect: evt gestureSource ]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ].
	self addChild: outputConnect
]

{ #category : 'initialization' }
ToWidgetElement >> initializeSliderLabel: aString [

	| label valueLabel container |
	label := BlTextElement new.
	label text: (aString , ':  ') asRopedText.
	valueLabel := BlTextElement new.
	valueLabel text: 0 asRopedText.

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
ToWidgetElement >> initializeSliders [ 

	slidersDic keysAndValuesDo: [ :key :value | 
		|sliderLabel|
		sliderLabel := self initializeSliderLabel: key.
		self connectSlider: value toLabel: sliderLabel.
		].
]

{ #category : 'initialization' }
ToWidgetElement >> initializeSlidersContainer [

	slidersContainer := BlElement new.
	slidersContainer layout: BlLinearLayout new.
	slidersContainer layout beVertical.
	slidersContainer constraintsDo: [ :c |
		c margin: (BlInsets top: 25).
		c vertical fitContent.
		c horizontal fitContent.
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self addChild: slidersContainer
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
ToWidgetElement >> name [
	^ name
]

{ #category : 'accessing' }
ToWidgetElement >> name: aString [
	name := aString.
	barElement name: aString.
]

{ #category : 'instance creation' }
ToWidgetElement >> newRawSkin [
	^ ToWidgetElementSkin new
]

{ #category : 'announcer connection' }
ToWidgetElement >> notifyConnection [

	self announcer announce: ConnectionAnnouncer new
]

{ #category : 'announcer connection' }
ToWidgetElement >> notifyDisconnection [

	self announcer announce: DisconnectionAnnouncer new
]

{ #category : 'accessing' }
ToWidgetElement >> notifyDrawingLine [
	self announcer announce: LineCurrentlyDrawAnnouncer new.
]

{ #category : 'drawing' }
ToWidgetElement >> notifyEnableCreation [
	self announcer announce: EnableCreationAnnouncer.
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
ToWidgetElement >> phaustoSound: aPhaustoSoundAsDsp [

	phaustoSound := aPhaustoSoundAsDsp.
]

{ #category : 'initialization' }
ToWidgetElement >> resetToInit [

	(self isConnector: inputConnect) ifTrue: [ inputConnect resetInit ].
	(self isConnector: outputConnect) ifTrue: [ outputConnect resetInit ].
	self notifyDrawingLine
]

{ #category : 'accessing' }
ToWidgetElement >> sliderIndex: aSlider [

	| key |
	1 to: slidersDic size do: [ :i |
		key := slidersDic keys at: i.
		((slidersDic at: key) = aSlider) ifTrue: [ ^ i ] ].
	^ 0
]

{ #category : 'accessing' }
ToWidgetElement >> slidersContainer [
	^ slidersContainer
]

{ #category : 'accessing' }
ToWidgetElement >> slidersDic [

	^ slidersDic
]

{ #category : 'accessing' }
ToWidgetElement >> slidersDic: aDictionaryOfSlidersWithLabelKey [

	slidersDic := aDictionaryOfSlidersWithLabelKey.
	self initializeSliders.
]
