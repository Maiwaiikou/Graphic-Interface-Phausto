Class {
	#name : 'JamMenuItem',
	#superclass : 'BlTextElement',
	#instVars : [
		'title',
		'widget',
		'spaceElement',
		'action',
		'name'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'accessing' }
JamMenuItem >> action [
	^ action
]

{ #category : 'accessing' }
JamMenuItem >> action: aBlock [

	action := aBlock
]

{ #category : 'initialization' }
JamMenuItem >> initialize [

	super initialize.
	self initializeEvents
]

{ #category : 'accessing' }
JamMenuItem >> initializeEvents [

	self addEventHandlerOn: BlClickEvent do: [ action value ].
]

{ #category : 'accessing' }
JamMenuItem >> name [
	^ name
]

{ #category : 'accessing' }
JamMenuItem >> name: aString [

	name := aString.
	self text: name asRopedText.
]

{ #category : 'accessing' }
JamMenuItem >> spaceElement [
	^ spaceElement
]

{ #category : 'accessing' }
JamMenuItem >> spaceElement: anElement [

	spaceElement := anElement
]

{ #category : 'accessing' }
JamMenuItem >> widget [
	^ widget
]

{ #category : 'accessing' }
JamMenuItem >> widget: aWidget [

	widget := aWidget.
	self name: aWidget name
]
