Class {
	#name : 'Interface',
	#superclass : 'BlElement',
	#instVars : [
		'menu',
		'childrenElements',
		'micro',
		'audio',
		'lines'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'accessing' }
Interface >> audio [
	^ audio
]

{ #category : 'accessing' }
Interface >> childrenElements [
	^ childrenElements
]

{ #category : 'accessing' }
Interface >> childrenElements: aCollectionOfElements [
	childrenElements := aCollectionOfElements.
	self drawElement.
]

{ #category : 'as yet unclassified' }
Interface >> drawChildren [

	childrenElements do: [ :elt |
		self addChild: elt.
			(elt isConnector: elt inputConnect ) ifTrue: [
				self addChild: elt inputConnect line ].
			(elt isConnector: elt outputConnect) ifTrue: [
				self addChild: elt outputConnect line ] ].
]

{ #category : 'as yet unclassified' }
Interface >> drawElement [

	self removeChildren.
	self addChild: menu.
	self addChild: micro.
	self addChild: micro outputConnect line.
	self addChild: audio.
	self addChild: audio inputConnect line.
	self drawChildren
]

{ #category : 'initialization' }
Interface >> initialize [

	super initialize.
	childrenElements := OrderedCollection new.
	self size: 800 @ 600.
	menu := MenuElement withWidgets.
	self initializeMicro.
	self initializeAudio.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(evt gestureSource isKindOf: Connector) ifTrue: [
			evt gestureSource line: BlElement new.
			self drawElement ] ].
	self drawElement
]

{ #category : 'initialization' }
Interface >> initializeAudio [

	audio := ToWidgetWithIconElement withAudioIcon.
	"TODO : Action audio"
	audio announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	audio position: 400 @ 150
]

{ #category : 'initialization' }
Interface >> initializeMicro [

	micro := ToWidgetWithIconElement withMicroIcon.
	"TODO : Action mic"
	micro announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	micro position: 0 @ 150
]

{ #category : 'accessing' }
Interface >> menu [
	^ menu
]

{ #category : 'accessing' }
Interface >> menu: aMenuElement [
	menu := aMenuElement.
	self drawElement.
]

{ #category : 'accessing' }
Interface >> micro [
	^ micro
]

{ #category : 'instance creation' }
Interface >> open [
	|space|
	space := BlSpace new.
	space toTheme: ToWidgetTheme new.
	space root addChild: self.
	space show
]

{ #category : 'initialization' }
Interface >> resetElements [

	micro resetToInit.
	audio resetToInit.
	childrenElements do: [ :elt |
		(elt isKindOf: ToWidgetElement) ifTrue: [ elt resetToInit ] ]
]
