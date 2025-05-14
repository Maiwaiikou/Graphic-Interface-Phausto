Class {
	#name : 'ToWidgetWithIconElement',
	#superclass : 'ToWidgetElement',
	#instVars : [
		'icon'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'as yet unclassified' }
ToWidgetWithIconElement class >> withAudioIcon [
	|widget|
	widget := self onlyWithLeftConnector.
	widget initializeNewIconFromURL: 'https://cdn-icons-png.flaticon.com/128/6996/6996058.png'.
	^ widget
]

{ #category : 'as yet unclassified' }
ToWidgetWithIconElement class >> withMicroIcon [
	|widget|
	widget := self onlyWithRightConnector.
	widget initializeNewIconFromURL: 'https://cdn-icons-png.flaticon.com/128/25/25682.png'.
	^ widget
]

{ #category : 'drawing' }
ToWidgetWithIconElement >> draw [
	self removeChildren.
	self addChild: leftConnect.
	self addChild: rightConnect.
	self addChild: icon
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
	super initialize.
]

{ #category : 'initialization' }
ToWidgetWithIconElement >> initializeNewIconFromURL: anURL [
	icon := ((ZnEasy getPng: anURL) scaledToSize:50@50) asElement.
	self draw.
]
