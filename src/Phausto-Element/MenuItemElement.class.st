Class {
	#name : 'MenuItemElement',
	#superclass : 'ToMenuItem',
	#instVars : [
		'widget'
	],
	#category : 'Phausto-Element-Menu',
	#package : 'Phausto-Element',
	#tag : 'Menu'
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
