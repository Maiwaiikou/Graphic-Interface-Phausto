"
The interface which regroup all UIElement of the PharoJamSession compose with widgets and a menu.
"
Class {
	#name : 'Interface',
	#superclass : 'BlElement',
	#instVars : [
		'menu',
		'childrenElements',
		'widgetsLines',
		'micro',
		'audio',
		'activeDSP',
		'theme'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
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
Interface >> addChildElement: aWidget [

	childrenElements add: aWidget.
	self drawElement
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

{ #category : 'accessing' }
Interface >> clear [
	self removeChildren.
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

	self removeElementExcept: {
			menu.
			micro.
			audio }.

	self addChild: micro outputConnect line.
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
Interface >> handleAudioDisconnectedEventFor: anActiveDSP [

	anActiveDSP stop.
	activeDSP removeChild: anActiveDSP.
]

{ #category : 'initialization' }
Interface >> initialize [

	super initialize.
	childrenElements := OrderedCollection new.
	activeDSP := OrderedCollection new.
	self size: 1000 @ 600.
	self initializeDefaultTheme.
	self initializeMenu.
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
	audio position: 930 @ 150.
	self addChild: audio.
]

{ #category : 'initialization' }
Interface >> initializeDefaultTheme [
	theme := ToWidgetTheme new
]

{ #category : 'initialization' }
Interface >> initializeMenu [

	menu := MenuElement new.
	self addChild: menu.
	menu defaultConstrains.
]

{ #category : 'initialization' }
Interface >> initializeMicro [
	|mic effect|
	mic := Wire new.
	effect := JamEchoDelay new.
	micro := ToWidgetWithIconElement withMicroIcon phaustoSound: ((mic => effect) stereo asDsp).
	micro announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	micro position: 0 @ 150.
	self addChild: micro.
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
	space toTheme: theme.
	space root addChild: self.
	space extent: 1000 @ 600.
	space show
]

{ #category : 'removing' }
Interface >> removeElementExcept: aListOfElementToNotDelete [
	|childrenCopy|
	childrenCopy := children copy.
	childrenCopy do: [ : item | 
		(aListOfElementToNotDelete includes: item)ifFalse: [ self removeChild: item ]. 
		]
]

{ #category : 'initialization' }
Interface >> resetElements [
	menu refreshMenu.
	micro resetToInit.
	audio resetToInit.
	childrenElements do: [ :elt | elt resetToInit ].
]

{ #category : 'accessing' }
Interface >> theme [
	^ theme
]

{ #category : 'accessing' }
Interface >> theme: aTheme [

	theme := aTheme
]
