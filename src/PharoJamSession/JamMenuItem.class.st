Class {
	#name : 'JamMenuItem',
	#superclass : 'ToButton',
	#instVars : [
		'title',
		'widget',
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
	self background: Color orange.
	self initializeEvents
]

{ #category : 'accessing' }
JamMenuItem >> initializeEvents [

	self addEventHandlerOn: BlClickEvent do: [ 
		spaceElement addChild: widget.
		self disable
		"action ensure" ]
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
	self labelText: aWidget name.
]
