"
I'm a menu for JamSession, when you click on me it show you a subMenu containers with all of my subMenu sort by categories. Every click on subMenu do an JamMenuAction and it handle action for widget creation (initializeWidget: inList:) but also every type of subMenu you want or if you want to create other action during widget creation (initializeDefaultElement: inList). My subMenu container disappear when your mouse is out of it and his children.
"
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
JamMenu class >> defaultFileMenu [

	| menu dict |
	menu := self new title: 'File'.
	dict := OrderedDictionary new.
	{ 'New page'. 'Open a file'. 'Save'. 'Save as'. 'Clear' } do: [ :elt |
		dict at: elt put: [  ] ].
	dict at: 'New page' put: [
		JamSession new
			theme: menu spaceElement theme;
			open ].
	dict at: 'Clear' put: [
		menu spaceElement resetElements.
		menu spaceElement childrenElements removeAll.
		menu spaceElement drawElement ].
	menu categories: { ('' -> dict) } asDictionary.
	^ menu
]

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

{ #category : 'initialization' }
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
	self minWidth: 70.
	categories := Dictionary new.
	labelCategories := OrderedCollection new.
	allButtonsContainers := OrderedCollection new.
	configuredAttributes := OrderedCollection new.

	self initializeTitle.
	self initializeSubMenuContainer.
	self initializeEvent
]

{ #category : 'initialization' }
JamMenu >> initializeButtonsContainer: aCollection [

	| list scrollBar container |
	list := ToListElement new constraintsDo: [ :c |
		        c margin: (BlInsets all: 10).
		        c horizontal fitContent ].
	aCollection isDictionary
		ifTrue: [ self initializeDefaultElement: aCollection inList: list ]
		ifFalse: [ self initializeWidget: aCollection inList: list ].
	scrollBar := BlVerticalScrollbarElement new.
	scrollBar constraintsDo: [ :c |
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight ].
	scrollBar attachTo: list innerElement.

	container := ToElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c margin: (BlInsets all: 5).
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
		label constraintsDo: [ :c | c margin: (BlInsets left: 65) ].
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
JamMenu >> initializeDefaultElement: aCollection inList: aListElement [

	aListElement dataAccessor addAll: (aCollection keys).
	aListElement nodeBuilder: [ :node :key |
		| item |
		item := JamMenuItem new
						name: key asString;
			        action: (aCollection at:key);
			        spaceElement: spaceElement.
		self configuredMenuItem: item.
		node addChild: item ]
]

{ #category : 'initialization' }
JamMenu >> initializeEvent [

	self addEventHandlerOn: BlClickEvent do: [
			(spaceElement children includes: subMenuContainer) ifFalse: [
					subMenuContainer position: self positionInSpace x @ self height.
					spaceElement addChild: subMenuContainer . ] ]
]

{ #category : 'initialization' }
JamMenu >> initializeSubMenuContainer [

	subMenuContainer := ToElement new.
	subMenuContainer layout: BlLinearLayout new.
	subMenuContainer constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	subMenuContainer addEventFilterOn: BlMouseOutEvent do: [ :evt |
			| pos size |
			pos := subMenuContainer positionInSpace.
			size := subMenuContainer extent.
			(spaceElement children includes: subMenuContainer) ifTrue: [
					((evt position x between: pos x and: (pos + size) x) and:
						 (evt position y between: pos y and: (pos + size) y)) ifFalse: [
						spaceElement removeChild: subMenuContainer ] ] ]
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
JamMenu >> initializeWidget: aCollectionOfWidget inList: aListElement [

	aListElement dataAccessor addAll: aCollectionOfWidget.

	aListElement nodeBuilder: [ :node :widget |
		| item |
		widget announcer
			when: LineCurrentlyDrawAnnouncer
			send: #drawElement
			to: spaceElement.
		item := JamMenuItem new
			        name: widget name;
			        action: [
				        widget atRandomPos.
				        (spaceElement children includes: widget) ifFalse: [
						        spaceElement addChildElement: widget.
						        widget parent synthPatch add: widget phaustoSound ].
				        node disable ];
			        spaceElement: spaceElement.
		self configuredMenuItem: item.
		node addChild: item ]
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
