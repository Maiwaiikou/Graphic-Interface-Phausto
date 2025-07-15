"
I'm a sort of JamWidgetElement but I don't have synthPatch so I don't have any sliders, I only have an icon at the middle and connectors. As my parent class, I can be drag and drop.
"
Class {
	#name : 'JamWidgetWithIconElement',
	#superclass : 'JamAbstractWidgetElement',
	#instVars : [
		'icon'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'examples' }
JamWidgetWithIconElement class >> exampleWidgetWithAIcon [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self new initializeNewIconFromURL:
			 'https://i.ebayimg.com/images/g/kE8AAOSwpzJhwRn~/s-l400.png').
	interface open
]

{ #category : 'as yet unclassified' }
JamWidgetWithIconElement class >> withAudioIcon [

	| widget |
	widget := self onlyWithInputConnector.
	widget initializeNewIconFromURL:
		'https://cdn-icons-png.flaticon.com/128/6996/6996058.png'.
	widget icon constraintsDo: [ :c | c frame horizontal alignRight ].
	^ widget
]

{ #category : 'as yet unclassified' }
JamWidgetWithIconElement class >> withMicroIcon [
	|widget|
	widget := self onlyWithOutputConnector.
	widget initializeNewIconFromURL: 'https://cdn-icons-png.flaticon.com/128/25/25682.png'.
	widget icon constraintsDo: [ :c |
		c frame horizontal alignLeft ].
	^ widget
]

{ #category : 'accessing' }
JamWidgetWithIconElement >> announcer [
	^ announcer ifNil: [ announcer := Announcer new. ]
]

{ #category : 'drawing' }
JamWidgetWithIconElement >> draw [

	(self children includes: barElement) ifTrue: [ self removeChild: barElement ].
	self drawIcon
]

{ #category : 'drawing' }
JamWidgetWithIconElement >> drawIcon [
	icon constraintsDo: [ :c |
		c frame vertical alignCenter ].
	self addChild: icon.
]

{ #category : 'initialization' }
JamWidgetWithIconElement >> icon [
	^ icon
]

{ #category : 'initialization' }
JamWidgetWithIconElement >> icon: anElement [
	icon := anElement.
]

{ #category : 'initialization' }
JamWidgetWithIconElement >> initialize [

	icon := BlElement new.
	super initialize.
	self initializeDragWidgetEventOn: self.
]

{ #category : 'initialization' }
JamWidgetWithIconElement >> initializeNewIconFromURL: anURL [
	icon:= ((ZnEasy getPng: anURL) scaledToSize:50@50) asElement.
	self draw.
]

{ #category : 'instance creation' }
JamWidgetWithIconElement >> newRawSkin [
	^ JamWidgetWithIconElementSkin new.
]

{ #category : 'announcer connection' }
JamWidgetWithIconElement >> notifyConnection [

	self announcer announce: SpeakerConnectionAnnouncer new.
	Object inform: 'CONNECTED TO SPEAKER'
]

{ #category : 'announcer connection' }
JamWidgetWithIconElement >> notifyConnectionWith: aSource [

	self announcer announce: (SpeakerConnectionAnnouncer new source: aSource).
	Object inform: 'CONNECTED TO SPEAKER'
]

{ #category : 'announcer connection' }
JamWidgetWithIconElement >> notifyDisconnection [

	self announcer announce: SpeakerDisconnectionAnnouncer new
]
