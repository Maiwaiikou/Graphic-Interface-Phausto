Class {
	#name : 'Interface',
	#superclass : 'BlElement',
	#instVars : [
		'menu',
		'childrenElements',
		'micro',
		'audio',
		'activeDSP'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'accessing' }
Interface >> activeDSP [
	^ activeDSP
]

{ #category : 'accessing' }
Interface >> activeDSP: aCollectionOfDSP [

	activeDSP := aCollectionOfDSP
]

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

{ #category : 'drawing' }
Interface >> drawChildren [

	childrenElements do: [ :elt |
		self addChild: elt.
			(elt isConnector: elt inputConnect ) ifTrue: [
				self addChild: elt inputConnect line ].
			(elt isConnector: elt outputConnect) ifTrue: [
				self addChild: elt outputConnect line ] ].
]

{ #category : 'drawing' }
Interface >> drawElement [

	self removeChildren.
	self addChild: menu.
	menu defaultConstrains.

	self addChild: micro.
	self addChild: micro outputConnect line.

	self addChild: audio.
	self addChild: audio inputConnect line.

	self drawChildren
]

{ #category : 'initialization' }
Interface >> handleAudioConnectedEvent: aWidget [

	| nextConnected dsp |
	nextConnected := (aWidget isConnector: aWidget inputConnect)
		                 ifTrue: [ aWidget inputConnect connectTo ]
		                 ifFalse: [ nil ].
	aWidget phaustoSound ifNotNil: [
		dsp := aWidget phaustoSound.
		dsp init.
		dsp start.
		activeDSP add: dsp ].
	nextConnected ifNotNil: [
		self handleAudioConnectedEvent: nextConnected ]
]

{ #category : 'initialization' }
Interface >> handleAudioDisconnectedEvent [

	activeDSP do: [ :dsp | dsp stop ].
	activeDSP removeAll.
]

{ #category : 'initialization' }
Interface >> initialize [

	super initialize.
	childrenElements := OrderedCollection new.
	activeDSP := OrderedCollection new.
	self size: 1000 @ 600.
	menu := MenuElement withWidgets.
	self initializeMicro.
	self initializeAudio.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource class = Connector ifTrue: [
			evt gestureSource line: BlElement new.
			self drawElement ] ].
	self drawElement
]

{ #category : 'initialization' }
Interface >> initializeAudio [

	audio := ToWidgetWithIconElement withAudioIcon.
	audio announcer
		when: ConnectionAnnouncer
		do: [ self handleAudioConnectedEvent: audio ]
		for: audio.
	audio announcer
		when: DisconnectionAnnouncer
		send: #handleAudioDisconnectedEvent
		to: self.
	audio announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	audio position: 930 @ 150
]

{ #category : 'initialization' }
Interface >> initializeMicro [

	micro := ToWidgetWithIconElement withMicroIcon.
	self flag: #todo.
	"Mic event action"
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

	| space |
	space := BlSpace new.
	space toTheme: ToWidgetTheme new.
	space root addChild: self.
	space extent: 1000@600.
	space show
]

{ #category : 'initialization' }
Interface >> resetElements [
	menu refreshMenu.
	micro resetToInit.
	audio resetToInit.
	childrenElements do: [ :elt | elt resetToInit ].
]
