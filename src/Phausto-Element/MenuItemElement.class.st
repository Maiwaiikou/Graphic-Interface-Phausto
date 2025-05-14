Class {
	#name : 'MenuItemElement',
	#superclass : 'ToMenuItem',
	#instVars : [
		'widget'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'initialization' }
MenuItemElement >> resetLabelText [
	self labelText: widget name
]

{ #category : 'initialization' }
MenuItemElement >> widget [
	^widget
]

{ #category : 'initialization' }
MenuItemElement >> widget: aWidget [
	widget := aWidget.
	self resetLabelText.
]
