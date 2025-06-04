Class {
	#name : 'ToWidgetWithIconElement',
	#superclass : 'ToWidgetElement',
	#instVars : [
		'icon'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
ToWidgetWithIconElement class >> withAudioIcon [

	| widget |
	widget := self onlyWithInputConnector.
	widget initializeNewIconFromURL:
		'https://cdn-icons-png.flaticon.com/128/6996/6996058.png'.
	widget icon constraintsDo: [ :c | c frame horizontal alignRight ].
	^ widget
]

{ #category : 'as yet unclassified' }
ToWidgetWithIconElement class >> withMicroIcon [
	|widget|
	widget := self onlyWithOutputConnector.
	widget initializeNewIconFromURL: 'https://cdn-icons-png.flaticon.com/128/25/25682.png'.
	widget icon constraintsDo: [ :c |
		c frame horizontal alignLeft ].
	^ widget
]

{ #category : 'drawing' }
ToWidgetWithIconElement >> draw [
	self removeChildren.
	self addChild: inputConnect.
	self addChild: outputConnect.
	self drawIcon.
]

{ #category : 'drawing' }
ToWidgetWithIconElement >> drawIcon [
	icon constraintsDo: [ :c |
		c frame vertical alignCenter ].
	self addChild: icon.
]

{ #category : 'initialization' }
ToWidgetWithIconElement >> icon [
	^ icon
]

{ #category : 'initialization' }
ToWidgetWithIconElement >> icon: anElement [
	icon := anElement.
]

{ #category : 'initialization' }
ToWidgetWithIconElement >> initialize [
	icon := BlElement new.
	super initialize.
]

{ #category : 'initialization' }
ToWidgetWithIconElement >> initializeNewIconFromURL: anURL [
	icon:= ((ZnEasy getPng: anURL) scaledToSize:50@50) asElement.
	self draw.
]

{ #category : 'instance creation' }
ToWidgetWithIconElement >> newRawSkin [
	^ ToWidgetWithIconElementSkin new.
]
