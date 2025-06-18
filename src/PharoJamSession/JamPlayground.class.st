"
The interface which regroup all UIElement of the PharoJamSession compose with widgets and a menu.
"
Class {
	#name : 'JamPlayground',
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
JamPlayground >> activeDSP [
	^ activeDSP
]

{ #category : 'accessing' }
JamPlayground >> activeDSP: aCollectionOfDSP [

	activeDSP := aCollectionOfDSP
]

{ #category : 'accessing' }
JamPlayground >> addChildElement: aWidget [

	childrenElements add: aWidget.
	self drawElement
]

{ #category : 'accessing' }
JamPlayground >> audio [
	^ audio
]

{ #category : 'accessing' }
JamPlayground >> childrenElements [
	^ childrenElements
]

{ #category : 'accessing' }
JamPlayground >> childrenElements: aCollectionOfElements [
	childrenElements := aCollectionOfElements.
	self drawElement.
]

{ #category : 'accessing' }
JamPlayground >> clear [
	self removeChildren.
]

{ #category : 'drawing' }
JamPlayground >> drawChildren [

	childrenElements do: [ :elt |
		self addChild: elt.
			(elt isConnector: elt inputConnect ) ifTrue: [
				self addChild: elt inputConnect line ].
			(elt isConnector: elt outputConnect) ifTrue: [
				self addChild: elt outputConnect line ] ].
]

{ #category : 'drawing' }
JamPlayground >> drawElement [

	self removeElementExcept: {
			menu.
			micro.
			audio }.

	self addChild: micro outputConnect line.
	self addChild: audio inputConnect line.
	self drawChildren
]

{ #category : 'element events handling' }
JamPlayground >> handleAudioConnectedEvent: aWidget [

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
JamPlayground >> handleAudioDisconnectedEvent [

	activeDSP do: [ :dsp | dsp stop ].
	activeDSP removeAll.
]

{ #category : 'element events handling' }
JamPlayground >> handleAudioDisconnectedEventFor: anActiveDSP [

	anActiveDSP stop.
	activeDSP removeChild: anActiveDSP.
]

{ #category : 'initialization' }
JamPlayground >> initialize [

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
JamPlayground >> initializeAudio [

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
JamPlayground >> initializeDefaultTheme [

	theme := JamTheme new
]

{ #category : 'initialization' }
JamPlayground >> initializeMenu [

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
JamPlayground >> initializeMicro [
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
JamPlayground >> menu [
	^ menu
]

{ #category : 'accessing' }
JamPlayground >> menu: aMenuElement [
	menu := aMenuElement.
	self drawElement.
]

{ #category : 'accessing' }
JamPlayground >> micro [
	^ micro
]

{ #category : 'instance creation' }
JamPlayground >> newRawSkin [
	^ JamPlaygroundSkin new
]

{ #category : 'instance creation' }
JamPlayground >> open [

	| space |
	self installRawStyle.
	space := BlSpace new.
	space toTheme: theme.
	space root addChild: self.
	space extent: sizeElt.
	space show
]

{ #category : 'removing' }
JamPlayground >> removeElementExcept: aListOfElementToNotDelete [
	|childrenCopy|
	childrenCopy := children copy.
	childrenCopy do: [ : item | 
		(aListOfElementToNotDelete includes: item)ifFalse: [ self removeChild: item ]. 
		]
]

{ #category : 'initialization' }
JamPlayground >> resetElements [
	menu refreshMenu.
	micro resetToInit.
	audio resetToInit.
	childrenElements do: [ :elt | elt resetToInit ].
]

{ #category : 'initialization' }
JamPlayground >> sizeElt [
	^ sizeElt
]

{ #category : 'initialization' }
JamPlayground >> sizeElt: aPoint [
	sizeElt := aPoint.
]

{ #category : 'accessing' }
JamPlayground >> theme [

	^ theme
]

{ #category : 'accessing' }
JamPlayground >> theme: aTheme [

	theme := aTheme
]
