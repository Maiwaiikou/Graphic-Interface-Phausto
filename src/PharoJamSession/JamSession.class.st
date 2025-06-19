"
The interface which regroup all UIElement of the PharoJamSession compose with widgets and a menu.
"
Class {
	#name : 'JamSession',
	#superclass : 'ToElement',
	#instVars : [
		'menu',
		'childrenElements',
		'micro',
		'audio',
		'activeDSP',
		'theme',
		'sizeElt'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'accessing' }
JamSession >> activeDSP [
	^ activeDSP
]

{ #category : 'accessing' }
JamSession >> activeDSP: aCollectionOfDSP [

	activeDSP := aCollectionOfDSP
]

{ #category : 'accessing' }
JamSession >> addChildElement: aWidget [

	childrenElements add: aWidget.
	self drawElement
]

{ #category : 'accessing' }
JamSession >> audio [
	^ audio
]

{ #category : 'accessing' }
JamSession >> childrenElements [
	^ childrenElements
]

{ #category : 'accessing' }
JamSession >> childrenElements: aCollectionOfElements [
	childrenElements := aCollectionOfElements.
	self drawElement.
]

{ #category : 'accessing' }
JamSession >> clear [
	self removeChildren.
]

{ #category : 'drawing' }
JamSession >> drawChildren [

	childrenElements do: [ :elt |
		self addChild: elt.
			(elt isConnector: elt inputConnect ) ifTrue: [
				self addChild: elt inputConnect line ].
			(elt isConnector: elt outputConnect) ifTrue: [
				self addChild: elt outputConnect line ] ].
]

{ #category : 'drawing' }
JamSession >> drawElement [

	self removeElementExcept: {
			menu.
			micro.
			audio }.

	self addChild: micro outputConnect line.
	self addChild: audio inputConnect line.
	self drawChildren
]

{ #category : 'element events handling' }
JamSession >> handleAudioConnectedEvent: aWidget [

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

{ #category : 'element events handling' }
JamSession >> handleAudioDisconnectedEvent [

	activeDSP do: [ :dsp | dsp stop ].
	activeDSP removeAll.
]

{ #category : 'element events handling' }
JamSession >> handleAudioDisconnectedEventFor: anActiveDSP [

	anActiveDSP stop.
	activeDSP removeChild: anActiveDSP.
]

{ #category : 'initialization' }
JamSession >> initialize [

	super initialize.
	childrenElements := OrderedCollection new.
	activeDSP := OrderedCollection new.
	self layout: BlBasicLayout new.
	sizeElt := 1200 @ 600.
	self size: sizeElt.
	self initializeDefaultTheme.
	self initializeMenu.
	self initializeMicro.
	self initializeAudio.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		evt gestureSource class = JamConnector ifTrue: [
			evt gestureSource line: BlElement new.
			self drawElement ] ].
	self drawElement
]

{ #category : 'initialization' }
JamSession >> initializeAudio [

	audio := JamWidgetWithIconElement withAudioIcon.
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
	audio position: 1130 @ 150.
	self addChild: audio
]

{ #category : 'initialization' }
JamSession >> initializeDefaultTheme [

	theme := JamTheme new
]

{ #category : 'initialization' }
JamSession >> initializeMenu [

	menu := JamMenuElement new.
	menu constraintsDo: [ :c |
		c vertical fitContent.
		c frame vertical alignTop.
		c frame horizontal alignCenter ].
	menu width: sizeElt x.
	self addChild: menu
	"menu defaultConstrains"
]

{ #category : 'initialization' }
JamSession >> initializeMicro [
	|mic effect|
	mic := Wire new.
	effect := JamEchoDelay new.
	micro := JamWidgetWithIconElement withMicroIcon phaustoSound: ((mic => effect) stereo asDsp).
	"Mic event action"
	micro announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	micro position: 0 @ 150.
	self addChild: micro.
]

{ #category : 'accessing' }
JamSession >> menu [
	^ menu
]

{ #category : 'accessing' }
JamSession >> menu: aMenuElement [
	menu := aMenuElement.
	self drawElement.
]

{ #category : 'accessing' }
JamSession >> micro [
	^ micro
]

{ #category : 'instance creation' }
JamSession >> newRawSkin [
	^ JamPlaygroundSkin new
]

{ #category : 'instance creation' }
JamSession >> open [

	| space |
	self installRawStyle.
	space := BlSpace new.
	space toTheme: theme.
	space root addChild: self.
	space extent: sizeElt.
	space show
]

{ #category : 'removing' }
JamSession >> removeElementExcept: aListOfElementToNotDelete [
	|childrenCopy|
	childrenCopy := children copy.
	childrenCopy do: [ : item | 
		(aListOfElementToNotDelete includes: item)ifFalse: [ self removeChild: item ]. 
		]
]

{ #category : 'initialization' }
JamSession >> resetElements [
	menu refreshMenu.
	micro resetToInit.
	audio resetToInit.
	childrenElements do: [ :elt | elt resetToInit ].
]

{ #category : 'initialization' }
JamSession >> sizeElt [
	^ sizeElt
]

{ #category : 'initialization' }
JamSession >> sizeElt: aPoint [
	sizeElt := aPoint.
]

{ #category : 'accessing' }
JamSession >> theme [

	^ theme
]

{ #category : 'accessing' }
JamSession >> theme: aTheme [

	theme := aTheme
]
