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
	self size: 100 @ 100.
	self background: Color blue.
	self initializeTitle.
	self initializeSubMenuContainer.
	self initializeEvent
]

{ #category : 'initialization' }
JamMenu >> initializeButtonsContainer: aCollectionOfButton [

	| container |
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             height: 200;
		             background: Color lightBlue;
		             constraintsDo: [ :c | c horizontal fitContent ].
	aCollectionOfButton do: [ :button | button spaceElement: spaceElement.container addChild: button ].
	^ container
]

{ #category : 'initialization' }
JamMenu >> initializeCategories [

	| container label buttonContainer |
	categories keysAndValuesDo: [ :key :values |
		label := BlTextElement text: key asString asRopedText.
		buttonContainer := self initializeButtonsContainer: values.
		container := BlElement new
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
			subMenuContainer position: (self positionInSpace x) @100.
			spaceElement addChild: subMenuContainer ] ]
]

{ #category : 'initialization' }
JamMenu >> initializeSubMenuContainer [

	subMenuContainer := ToElement new.
	subMenuContainer size: 100 @ 100.
	subMenuContainer background: Color green.
	"subMenuContainer width: 200."
	subMenuContainer layout: BlLinearLayout new.
	subMenuContainer constraintsDo: [ :c | "c horizontal fitContent" ].
	subMenuContainer addEventHandlerOn: BlMouseOutEvent do: [
		self inform: 'out'.
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
