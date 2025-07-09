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
		'speaker',
		'activeDSP',
		'theme',
		'sizeElt',
		'synthesiser',
		'synthPatch'
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

{ #category : 'dsp management' }
JamSession >> disableDsp: anActiveDSP [

	anActiveDSP stop.
	activeDSP remove: anActiveDSP.
]

{ #category : 'dsp management' }
JamSession >> disconnectDsp [

	self activeDSP ifNotNil: [ self activeDSP stop; destroy ].
	activeDSP := nil.
]

{ #category : 'dsp management' }
JamSession >> disconnectedEachDsp [

	activeDSP do: [ :dsp | dsp stop ].
	activeDSP removeAll.
]

{ #category : 'drawing' }
JamSession >> drawChildren [

	childrenElements do: [ :elt |
		self addChild: elt.
		elt inputConnect ifNotNil: [
			elt inputConnect line ifNotNil: [
				self addChild: elt inputConnect line ] ].
		(elt outputConnect isNotNil and: elt outputConnect line isNotNil)
			ifTrue: [ self addChild: elt outputConnect line ] ]
]

{ #category : 'drawing' }
JamSession >> drawElement [

	self removeElementExcept: {
			menu.
			micro.
			speaker }.
	micro outputConnect line ifNotNil: [
		self addChild: micro outputConnect line ].
	speaker inputConnect line ifNotNil: [
		self addChild: speaker inputConnect line ].
	self drawChildren
]

{ #category : 'element events handling' }
JamSession >> handleSpeakerConnectedEvent [
	"self disconnectedEachDsp.
	speaker inputConnect connectTo do: [ :widget |
		self handleWidgetsConnected: widget ]"

	"	activeDSP := self synthPatch stereo asDsp."
   | ugenChain |
ugenChain := synthPatch collect: [ :i |i new ].

	activeDSP := ugenChain asArray asChainOfUGen stereo asDsp.
	activeDSP init.
	activeDSP start
]

{ #category : 'element events handling' }
JamSession >> handleSpeakerDisconnectedEvent [

	self flag: #ToFix.
	"Check on handleWidgetsDisconnected method to fix this one"
	self disconnectDsp
	"	self handleSpeakerConnectedEvent"
	"audio inputConnect connectTo do: [ :widget |
		self handleWidgetsDisconnected: widget ]"
]

{ #category : 'element events handling' }
JamSession >> handleWidgetsConnected: aWidget [

	| nextConnected dsp |
	
	nextConnected := (aWidget isConnector: aWidget inputConnect)
		                 ifTrue: [ aWidget inputConnect connectTo ]
		                 ifFalse: [ OrderedCollection new ].
		'STRONZO' traceCr.
	"aWidget phaustoSound ifNotNil: [
			dsp := aWidget phaustoSound.
			dsp init.
			dsp start.
			activeDSP add: dsp ]."
	nextConnected do: [ :each | self handleWidgetsConnected: each ]
]

{ #category : 'element events handling' }
JamSession >> handleWidgetsDisconnected: aWidget [

	| nextConnected |
	nextConnected := (aWidget isConnector: aWidget inputConnect)
		                 ifTrue: [ aWidget inputConnect connectTo ]
		                 ifFalse: [ OrderedCollection new ].
	self flag: #ToFix.
	"Why this cond is false at execution but when we put an halt before that told us it's true ?"
	((aWidget isConnectedTo: speaker) not and: [
		 activeDSP includes: aWidget phaustoSound ]) ifTrue: [
		self disableDsp: aWidget phaustoSound ].
	nextConnected do: [ :each | self handleWidgetsDisconnected: each ]
]

{ #category : 'initialization' }
JamSession >> initialize [

	super initialize.
	childrenElements := OrderedCollection new.
	synthPatch := OrderedCollection new.
	"	activeDSP := OrderedCollection new."
	self layout: BlBasicLayout new.
	sizeElt := 1200 @ 600.
	self size: sizeElt.
	self initializeDefaultTheme.
	self initializeMenu.
	self initializeMicro.
	self initializeSpeaker.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
			evt consumed: true.
			self flag: #ToChange.
			(evt gestureSource isKindOf: JamConnector) ifTrue: [
					evt gestureSource line: nil.
					self drawElement ] ].
	self drawElement
]

{ #category : 'initialization' }
JamSession >> initializeDefaultTheme [

	theme := JamTheme new
]

{ #category : 'initialization' }
JamSession >> initializeMenu [

	menu := JamMenuBar defaultMenuWithSpace: self.
	menu constraintsDo: [ :c | c horizontal matchParent ].

	"menu constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent.
		c frame vertical alignTop ]."
	self addChild: menu
]

{ #category : 'initialization' }
JamSession >> initializeMicro [

	| mic effect |
	mic := Wire new.
	effect := JamEchoDelay new.
	micro := JamWidgetWithIconElement withMicroIcon phaustoSound:
		         Wire new.
	"Mic event action"
	micro announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	micro position: 0 @ 150.
	self addChild: micro
]

{ #category : 'initialization' }
JamSession >> initializeSpeaker [

	speaker := JamWidgetWithIconElement withAudioIcon.
	speaker announcer
		when: ConnectionAnnouncer
		send: #handleSpeakerConnectedEvent
		to: self.
	speaker announcer
		when: DisconnectionAnnouncer
		send: #handleSpeakerDisconnectedEvent
		to: self.
	speaker announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: self.
	speaker position: 1130 @ 150.
	self addChild: speaker
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

	micro resetToInit.
	speaker resetToInit.
	childrenElements do: [ :elt | elt resetToInit ]
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
JamSession >> speaker [
	^ speaker
]

{ #category : 'accessing' }
JamSession >> synthPatch [

^ synthPatch 
]

{ #category : 'accessing' }
JamSession >> synthPatch: aUGenOrPhBox [

synthPatch := aUGenOrPhBox .
]

{ #category : 'accessing' }
JamSession >> theme [

	^ theme
]

{ #category : 'accessing' }
JamSession >> theme: aTheme [

	theme := aTheme
]
