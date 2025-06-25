Class {
	#name : 'JamMenu',
	#superclass : 'ToElement',
	#instVars : [
		'title',
		'spaceElement',
		'subMenuContainer',
		'categories'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'accessing' }
JamMenu >> categories [
	^ categories
]

{ #category : 'accessing' }
JamMenu >> categories: aDictionnary [

	categories := aDictionnary.
	self initializeCategories.
]

{ #category : 'initialization' }
JamMenu >> initialize [

	super initialize.
	title := ''.
	categories := Dictionary new.
	self background: Color blue.
	self initializeTitle.
	self initializeSubMenuContainer.
	self initializeEvent.
]

{ #category : 'initialization' }
JamMenu >> initializeButtonsContainer: aCollectionOfWidget [

	| list scrollBar container |
	list := ToListElement new constraintsDo: [ :c |
		        c margin: (BlInsets all: 10).
		        c horizontal fitContent ].
	list dataAccessor addAll: aCollectionOfWidget.
	list nodeBuilder: [ :node :widget |
		node addChild: (JamMenuItem new
				 widget: widget atRandomPos;
				 spaceElement: spaceElement) ].

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
		buttonContainer := self initializeButtonsContainer: values.
		container := ToElement new
			             layout: BlLinearLayout vertical;
			             background: Color lightGray;
			             constraintsDo: [ :c |
				             c frame horizontal alignCenter.
				             c margin: (BlInsets all: 5).
				             c vertical fitContent.
				             c horizontal fitContent ];
			             addChildren: {
					             label.
					             buttonContainer }.
		subMenuContainer addChild: container ]
]

{ #category : 'initialization' }
JamMenu >> initializeEvent [

	self addEventHandlerOn: BlClickEvent do: [
		(spaceElement children includes: subMenuContainer) ifFalse: [
			subMenuContainer position: self positionInSpace x @ 100.
			spaceElement addChild: subMenuContainer ] ].
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
		|pos size|
		pos := subMenuContainer positionInSpace.
		size := subMenuContainer size.
		(evt position x between: pos x and: (pos + size )x) ifFalse: [ spaceElement removeChild: subMenuContainer ].
		"spaceElement removeChild: subMenuContainer" ]
]

{ #category : 'initialization' }
JamMenu >> initializeTitle [

	title := BlTextElement new.
	title constraintsDo: [ :c | c margin: (BlInsets all: 50) ].
	self addChild: title
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
JamMenu >> title [
	^ title
]

{ #category : 'accessing' }
JamMenu >> title: aText [

	title text: (aText asRopedText)
]
