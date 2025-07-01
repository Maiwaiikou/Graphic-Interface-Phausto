Class {
	#name : 'JamMenu',
	#superclass : 'ToElement',
	#instVars : [
		'title',
		'spaceElement',
		'subMenuContainer',
		'categories',
		'labelCategories',
		'allButtonsContainers',
		'configuredAttributes'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
JamMenu class >> defaultSoundsMenu [
	^ (self new title:'Sounds'; categories: { 'Effects' -> JamWidgetElement widgetsEffects. 'Instruments' -> JamWidgetElement widgetsInstruments. 'Oscillators' -> JamWidgetElement widgetsOscillator. 'Synths' -> JamWidgetElement widgetsSynths. } asDictionary ).
]

{ #category : 'initialization' }
JamMenu >> allButtonsContainers [
	^ allButtonsContainers
]

{ #category : 'accessing' }
JamMenu >> categories [
	^ categories
]

{ #category : 'accessing' }
JamMenu >> categories: aDictionnary [

	categories := aDictionnary.
	self initializeCategories.
]

{ #category : 'accessing' }
JamMenu >> configuredAttributes [
	^ configuredAttributes
]

{ #category : 'accessing' }
JamMenu >> configuredAttributes: aCollectionOfAttributes [

	configuredAttributes := aCollectionOfAttributes
]

{ #category : 'as yet unclassified' }
JamMenu >> configuredMenuItem: aMenuItem [

	aMenuItem constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets all: 5) ].
	configuredAttributes ifNotEmpty: [
		aMenuItem width: configuredAttributes first.
		aMenuItem constraintsDo: [ :c | c padding: configuredAttributes second ].
		aMenuItem text attributes: (configuredAttributes allButFirst:2) ]
]

{ #category : 'initialization' }
JamMenu >> initialize [

	super initialize.
	title := ''.
	categories := Dictionary new.
	labelCategories := OrderedCollection new.
	allButtonsContainers := OrderedCollection new.
	configuredAttributes := OrderedCollection new.
	self initializeTitle.
	self initializeSubMenuContainer.
	self initializeEvent
]

{ #category : 'initialization' }
JamMenu >> initializeButtonsContainer: aCollectionOfWidget [

	| list scrollBar container |
	list := ToListElement new constraintsDo: [ :c |
		        c margin: (BlInsets all: 10).
		        c horizontal fitContent ].
	list dataAccessor addAll: aCollectionOfWidget.
	list nodeBuilder: [ :node :widget |
		| item |
		item := JamMenuItem new
			        widget: widget;
			        action: [
				        widget atRandomPos.
				        spaceElement addChild: widget.
				        node disable ];
			        spaceElement: spaceElement.
		self configuredMenuItem: item.
		node addChild: item
		"widget.
		self halt.
		node addChild: (JamMenuItem new
				 action: [
					 widget atRandomPos.
					 spaceElement addChild: widget.
					 node disable ];
				 spaceElement: spaceElement) " ].

	scrollBar := BlVerticalScrollbarElement new.
	scrollBar constraintsDo: [ :c |
		c margin: (BlInsets all: 5).
		c ignored horizontal alignRight ].
	scrollBar attachTo: list innerElement.

	container := ToElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c margin: (BlInsets all: 10).
			             c horizontal fitContent ].
	container height: 200.
	container addChildren: {
			list.
			scrollBar }.
	^ container
]

{ #category : 'initialization' }
JamMenu >> initializeCategories [

	| container label buttonContainer |
	categories keysAndValuesDo: [ :key :values |
		label := BlTextElement text: key asString asRopedText.
		label constraintsDo: [ :c |
			c margin: (BlInsets left: 65) ].
		buttonContainer := self initializeButtonsContainer: values.
		container := ToElement new
			             layout: BlLinearLayout vertical;
			             constraintsDo: [ :c |
				             c frame horizontal alignCenter.
				             c margin: (BlInsets all: 10).
				             c vertical fitContent.
				             c horizontal fitContent ];
			             addChildren: {
					             label.
					             buttonContainer }.
		labelCategories add: label.
		allButtonsContainers add: buttonContainer.
		subMenuContainer addChild: container ]
]

{ #category : 'initialization' }
JamMenu >> initializeEvent [

	self addEventHandlerOn: BlClickEvent do: [
		(spaceElement children includes: subMenuContainer) ifFalse: [
			subMenuContainer position: self positionInSpace x @ self height.
			spaceElement addChild: subMenuContainer ] ]
]

{ #category : 'initialization' }
JamMenu >> initializeSubMenuContainer [

	subMenuContainer := ToElement new.
	subMenuContainer background: Color green.
	subMenuContainer layout: BlLinearLayout new.
	subMenuContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	subMenuContainer addEventFilterOn: BlMouseOutEvent do: [ :evt |
		| pos size |
		pos := subMenuContainer positionInSpace.
		size := subMenuContainer size.
		(evt position x between: pos x and: (pos + size) x) ifFalse: [
			spaceElement removeChild: subMenuContainer ] ].
]

{ #category : 'initialization' }
JamMenu >> initializeTitle [

	title := BlTextElement new.
	title constraintsDo: [ :c |
		c margin: (BlInsets all: 5).
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self addChild: title
]

{ #category : 'initialization' }
JamMenu >> labelCategories [
	^ labelCategories
]

{ #category : 'instance creation' }
JamMenu >> newRawSkin [

	^ JamMenuSkin new.
]

{ #category : 'accessing' }
JamMenu >> spaceElement [

	^ spaceElement
]

{ #category : 'accessing' }
JamMenu >> spaceElement: anElement [

	spaceElement := anElement
]

{ #category : 'accessing' }
JamMenu >> subMenuContainer [
	^ subMenuContainer
]

{ #category : 'accessing' }
JamMenu >> title [
	^ title
]

{ #category : 'accessing' }
JamMenu >> title: aText [

	title text: (aText asRopedText)
]
