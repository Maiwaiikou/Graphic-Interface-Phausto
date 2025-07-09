"
I'm a menu item create for JamSession. I can handle an action given as block when we click on me.
"
Class {
	#name : 'JamMenuItem',
	#superclass : 'BlTextElement',
	#instVars : [
		'name',
		'spaceElement',
		'action'
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

	self addEventHandlerOn: BlClickEvent do: [
			action value.
			]
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
