"
I'm a ToMenuItemElement which have a attribut widget to it creation when someone click on me.
"
Class {
	#name : 'MenuItemElement',
	#superclass : 'ToMenuItem',
	#instVars : [
		'widget'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
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
