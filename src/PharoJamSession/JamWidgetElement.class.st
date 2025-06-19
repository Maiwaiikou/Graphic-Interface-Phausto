"
I'm the main caracter of the PharoJamSession, i'm compose of a BarElement who can move me in the interface, with at least one Cconnector and maximum 2 to link my attribut phaustoSound to another widget and with a slider container which regroup sliders of each parameter of my phaustoSound. 
"
Class {
	#name : 'JamWidgetElement',
	#superclass : 'ToElement',
	#instVars : [
		'barElement',
		'name',
		'slidersDic',
		'slidersLabels',
		'configuredAttributes',
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
JamWidgetElement class >> configureFor: anArrayOfClassName [

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
				put: (JamSliders withAPhControlParam: phControlParameter) ].
		widget initializeSliders.
		widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'configuring' }
JamWidgetElement class >> configureWithoutSoundFor: anArrayOfClassName [

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
				put: (JamSliders withAPhControlParam: phControlParameter) ].
		widget initializeSliders.
		widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithDifferentTheme [

	<example>
	| interface theme |
	interface := JamSession new clear.
	theme := ToRawTheme new.
	theme addTokenProperties: {
			(ToTokenProperty name: #'widget-background' value: Color white).
			(ToTokenProperty name: #'bar-background' value: (Color blue alpha: 0.5)).
			(ToTokenProperty
				 name: #'input-connect-background'
				 value: Color pink).
			(ToTokenProperty
				 name: #'output-connect-background'
				 value: Color purple).
			(ToTokenProperty
				 name: #'output-connect-background'
				 value: Color purple).
			(ToTokenProperty name: #'slider-background' value: Color red).
			(ToTokenProperty name: #'button-background' value: Color lightGray).
			(ToTokenProperty name: #'labels-text-color' value: Color magenta).
			(ToTokenProperty name: #'labels-text-size' value: 20).
			(ToTokenProperty
				 name: #'menuPane-background'
				 value: Color palePeach).
			(ToTokenProperty name: #'menuPane-height' value: 25).
			(ToTokenProperty name: #'menu-interspace' value: 15).
			(ToTokenProperty
				 name: #'JSPlayground-background'
				 value: Color transparent).
			(ToTokenProperty name:#'bar-border' value: (BlBorder paint: Color transparent width: 1))}.
	interface theme: theme.
	interface addChildElement: (self new
			 name: 'WindowsXp';
			 slidersDic: { ('Bug Counter' -> JamSliders new) } asDictionary).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithInputConnector [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self onlyWithInputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithMultipleSliders [

	<example>
	| interface dict |
	dict := OrderedDictionary new.
	'abcdefghijklmnopqstuvwxyz' do: [ :c | dict at: (c asString) put: JamSliders new ].
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: dict).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithOutputConnector [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self onlyWithOutputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithSliders [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: { ('Beauty' -> JamSliders new) } asDictionary).
	interface open.
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithTwoConnectors [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget').
	interface open
]

{ #category : 'configuring' }
JamWidgetElement class >> onlyWithInputConnector [

	| widget |
	widget := self new.
	widget removeChild: widget outputConnect.
	widget outputConnect: BlElement new.
	^ widget
]

{ #category : 'configuring' }
JamWidgetElement class >> onlyWithOutputConnector [

	| widget |
	widget := self new.
	widget removeChild: widget inputConnect.
	widget inputConnect: BlElement new.
	^ widget
]

{ #category : 'configuring' }
JamWidgetElement class >> typeOfWidget: aPhaustoElement [
	
	(aPhaustoElement numberOfInputs = 0) ifTrue: [ ^ self onlyWithOutputConnector ].
	(aPhaustoElement numberOfOutputs = 0) ifTrue: [ ^ self onlyWithInputConnector ].
	^ self new.
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsEffects [

	| effectsList effectsClass |
	effectsList := OrderedCollection new.
	effectsClass := ((PackageOrganizer default packageNamed:
		                  'PharoJamSession') tagNamed: 'Effect') classes.
	effectsClass do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ effectsList addAllFirstUnlessAlreadyPresent: subClass subclasses ]
			ifFalse: [
				(effectsList includes: subClass) ifFalse: [
					effectsList add: subClass ] ] ].
	^ self configureFor: effectsList
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsInstruments [

	| instList instClasses |
	instList := OrderedCollection new.
	instClasses := ((PackageOrganizer default packageNamed:
		                 'PharoJamSession') tagNamed: 'Instrument') classes.
	instClasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ instList addAllFirstUnlessAlreadyPresent: subClass subclasses ]
			ifFalse: [
			(instList includes: subClass) ifFalse: [ instList add: subClass ] ] ].
	^ self configureFor: instList
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsOscillator [

	| oscillators |
	oscillators := OrderedCollection new.
	Oscillator subclasses do: [ :subClass |
			subClass hasSubclasses ifTrue: [oscillators addAll: subClass subclasses] ifFalse: [ oscillators add: subClass ] ].
	^ self configureFor: oscillators
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsSynths [

	| synthsList |
	synthsList := OrderedCollection new.
	Synths subclasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ synthsList addAll: subClass subclasses ]
			ifFalse: [ synthsList add: subClass ] ].
	^ self configureWithoutSoundFor: synthsList
]

{ #category : 'drawing' }
JamWidgetElement >> adjustLine: aConnector [

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
	line border: (BlBorder paint: Color black width: 3).
	line addEventHandlerOn: BlClickEvent do: [
		aConnector disconnect.
		self notifyDrawingLine ].
	aConnector line: line.
	self notifyDrawingLine
]

{ #category : 'accessing' }
JamWidgetElement >> announcer [
	^ announcer ifNil: [ announcer := Announcer new. ]
]

{ #category : 'accessing' }
JamWidgetElement >> atRandomPos [

	| x y |
	x := (1 to: 600) atRandom.
	y := (50 to: 600) atRandom.
	self position: x @ y.
]

{ #category : 'accessing' }
JamWidgetElement >> barElement [
	^ barElement
]

{ #category : 'initialize-release' }
JamWidgetElement >> close [

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
JamWidgetElement >> configuredAttributes [
	^ configuredAttributes
]

{ #category : 'accessing' }
JamWidgetElement >> configuredAttributes: anOrderedCollection [
	"Attributes are defined in the theme and save for configure the label value which change everytime"
	configuredAttributes := anOrderedCollection
]

{ #category : 'accessing' }
JamWidgetElement >> configuredString: aString [
	|stringRoped|
	stringRoped := aString asRopedText.
	configuredAttributes ifNotEmpty: [ stringRoped attributes: configuredAttributes].
	^ stringRoped.
]

{ #category : 'initialization' }
JamWidgetElement >> connectSlider: aToSlider toLabel: aTextElement [

	aToSlider callBack: [ :value |
		aTextElement text: (self configuredString: ((value round: 2) asString)) ].
	aToSlider constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c margin: (BlInsets all: 5) ].
	slidersContainer addChild: aToSlider
]

{ #category : 'drawing' }
JamWidgetElement >> drawALine: points atConnector: aConnector [

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
JamWidgetElement >> initialize [

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
JamWidgetElement >> initializeBar [

	barElement := JamBarElement new name: self name.
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
JamWidgetElement >> initializeDragWidgetEventOn: anElement [

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
JamWidgetElement >> initializeEvents [

	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(self isConnector: evt gestureSource) ifTrue: [
			| line |
			line := evt gestureSource line.
			evt gestureSource isOutputConnect
				ifTrue: [
					line geometry vertices:
						line geometry vertices , { inputConnect positionInSpace + (inputConnect size /2) }.
					inputConnect connect: evt gestureSource ]
				ifFalse: [
					line geometry vertices:
						line geometry vertices , { outputConnect positionInSpace + (outputConnect size /2) }.
					outputConnect connect: evt gestureSource ].
			self adjustLine: evt gestureSource.
			self notifyDrawingLine ] ]
]

{ #category : 'initialization' }
JamWidgetElement >> initializeInputConnect [

	inputConnect := JamConnector new isInputConnect: true.
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
JamWidgetElement >> initializeOutputConnect [

	outputConnect := JamConnector new isOutputConnect: true.
	outputConnect constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	outputConnect transformDo: [ :t | t translateBy: 30 @ 0 ].
	outputConnect addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource isInputConnect
			ifTrue: [
				outputConnect connect: evt gestureSource.
				self adjustLine: evt gestureSource. 
				]
			ifFalse: [
				evt gestureSource line: BlElement new.
				self notifyDrawingLine ] ].
	self addChild: outputConnect
]

{ #category : 'initialization' }
JamWidgetElement >> initializeSliderLabel: aString [

	| label valueLabel container |
	label := BlTextElement new.
	label text: (aString , ':  ') asRopedText.
	valueLabel := BlTextElement new.
	valueLabel text: 0 asRopedText.
	slidersLabels addAll: { label. valueLabel }.
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
JamWidgetElement >> initializeSliders [ 

	slidersDic keysAndValuesDo: [ :key :value | 
		|sliderLabel|
		sliderLabel := self initializeSliderLabel: key.
		self connectSlider: value toLabel: sliderLabel.
		].
]

{ #category : 'initialization' }
JamWidgetElement >> initializeSlidersContainer [

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
JamWidgetElement >> inputConnect [

	^ inputConnect
]

{ #category : 'accessing' }
JamWidgetElement >> inputConnect: aConnector [

	inputConnect := aConnector
]

{ #category : 'testing' }
JamWidgetElement >> isConnector: anElement [
	^ anElement class = JamConnector.
	
]

{ #category : 'accessing' }
JamWidgetElement >> name [
	^ name
]

{ #category : 'accessing' }
JamWidgetElement >> name: aString [
	name := aString.
	barElement name: aString.
]

{ #category : 'instance creation' }
JamWidgetElement >> newRawSkin [
	^ JamWidgetElementSkin new
]

{ #category : 'announcer connection' }
JamWidgetElement >> notifyConnection [

	self announcer announce: ConnectionAnnouncer new
]

{ #category : 'announcer connection' }
JamWidgetElement >> notifyDisconnection [

	self announcer announce: DisconnectionAnnouncer new
]

{ #category : 'accessing' }
JamWidgetElement >> notifyDrawingLine [
	self announcer announce: LineCurrentlyDrawAnnouncer new.
]

{ #category : 'drawing' }
JamWidgetElement >> notifyEnableCreation [
	self announcer announce: EnableCreationAnnouncer.
]

{ #category : 'accessing' }
JamWidgetElement >> outputConnect [

	^ outputConnect
]

{ #category : 'accessing' }
JamWidgetElement >> outputConnect: aConnector [

	outputConnect := aConnector
]

{ #category : 'accessing' }
JamWidgetElement >> phaustoSound [
	^ phaustoSound
]

{ #category : 'accessing' }
JamWidgetElement >> phaustoSound: aPhaustoSoundAsDsp [

	phaustoSound := aPhaustoSoundAsDsp.
]

{ #category : 'initialization' }
JamWidgetElement >> resetToInit [

	(self isConnector: inputConnect) ifTrue: [ inputConnect resetInit ].
	(self isConnector: outputConnect) ifTrue: [ outputConnect resetInit ].
	self notifyDrawingLine
]

{ #category : 'accessing' }
JamWidgetElement >> sliderIndex: aSlider [

	| key |
	1 to: slidersDic size do: [ :i |
		key := slidersDic keys at: i.
		((slidersDic at: key) = aSlider) ifTrue: [ ^ i ] ].
	^ 0
]

{ #category : 'accessing' }
JamWidgetElement >> slidersContainer [
	^ slidersContainer
]

{ #category : 'accessing' }
JamWidgetElement >> slidersDic [

	^ slidersDic
]

{ #category : 'accessing' }
JamWidgetElement >> slidersDic: aDictionaryOfSlidersWithLabelKey [

	slidersDic := aDictionaryOfSlidersWithLabelKey.
	self initializeSliders.
]

{ #category : 'accessing' }
JamWidgetElement >> slidersLabels [
	^ slidersLabels
]

{ #category : 'accessing' }
JamWidgetElement >> slidersLabels: anOrderedCollection [
	slidersLabels := anOrderedCollection.
]
